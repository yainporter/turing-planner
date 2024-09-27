require 'redis'
host = ENV['REDIS_HOST'] || 'localhost' # Fallback to localhost if not set

$redis = Redis.new(
  host: host,
  port: 6379,
  password: ENV['REDIS_PASSWORD'] # Include this if required
)
