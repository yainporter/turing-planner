require 'redis'

if Rails.env == "test"
  redis_url = "redis://localhost:6379/1"
else
  redis_url = ENV['REDIS_URL'] || "redis://#{ENV['REDIS_HOST'] || 'localhost'}:6379/0"
end


$redis = Redis.new(url: redis_url)
