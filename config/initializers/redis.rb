redis_url = ENV["REDIS_CACHE_URL"]
REDIS = Redis.new(url: redis_url)
