class DailyDigestJob < ApplicationJob
  queue_as :default


  def perform
    User.schedule_daily_digest
  end

  # def perform(user_id)
  #   user = User.find(user_id)

  #   if user.lessons.today.exists?
  #     UserMailer.daily_digest(user).deliver_later
  #   else
  #     logger.info "No lessons today for User #{user.full_name} - no email sent."
  #   end

  # rescue ActiveRecord::RecordNotFound => e
  #   logger.error "User not found: #{e.message}"
  # end

end
