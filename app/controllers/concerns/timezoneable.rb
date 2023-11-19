module Timezoneable
  extend ActiveSupport::Concern

  included do
    def set_timezone
      Time.zone = current_user.timezone
    end

    def build_datetimes(lesson_params)
      if lesson_params[:starts_at] && lesson_params[:duration]
        lesson_params[:starts_at] = Time.zone.local_to_utc(DateTime.parse(lesson_params[:starts_at].to_s))
        lesson_params[:ends_at] = lesson_params[:starts_at] + (lesson_params[:duration].to_i.minutes)
      end

      lesson_params[:teacher_id] = current_user.id
      lesson_params
    end
  end
end
