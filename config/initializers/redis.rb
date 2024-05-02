redis_url = ENV.fetch("REDIS_CACHE_URL")
REDIS = Redis.new(url: redis_url)
