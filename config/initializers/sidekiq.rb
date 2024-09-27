Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_CACHE_URL', 'redis://localhost:6379/1') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_CACHE_URL', 'redis://localhost:6379/1') }
end
