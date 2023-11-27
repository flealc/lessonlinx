

Sidekiq.configure_server do
  Sidekiq::BasicFetch::TIMEOUT = 15
end


Sidekiq::Options[:cron_poll_interval] = 200 # Poll every 200 seconds
