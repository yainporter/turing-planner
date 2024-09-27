$hiredis = Hiredis::Connection.new
$hiredis.connect(ENV["REDIS_URL"] || "127.0.0.1", 6379)

if Rails.env == "test"
  $hiredis.select(1)
end
