module User::DailyDigestable
  extend ActiveSupport::Concern

  included do
    scope :signed_up_for_daily_digest, -> { where.not(daily_digest_at: nil) }
  end

  class_methods do
    def schedule_daily_digest
      User.signed_up_for_daily_digest.each do |user|
        send_at = DateTime.now.change(hour: user.daily_digest_at.hour, min: user.daily_digest_at.min).in_time_zone(user.timezone).utc
        send_at += 1.day if send_at.past?

        if user.lessons.today.any?
          Rails.logger.info "Scheduling daily digest for User: #{user.first_name}: ID: #{user.id} at #{send_at}"
          UserMailer.daily_digest(user).deliver_later(wait_until: send_at)
        else
          Rails.logger.info "No lessons today for User: #{user.first_name}: ID: #{user.id} - no email sent."
        end
      end
    end
  end
end
