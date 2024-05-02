module HiredisConnection
  def self.conn
    conn ||= Hiredis::Connection.new
    conn.connect("127.0.0.1", 6379)
    conn
  end
end
