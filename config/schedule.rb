every 1.day, at: '10:00 am' do
  runner "DailyEmailJob.perform_later(User.find_each)"
end
