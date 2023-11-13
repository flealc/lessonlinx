class DailyDigestJob < ApplicationJob
  queue_as :default


  def perform
    User.schedule_daily_digest
  end


end
