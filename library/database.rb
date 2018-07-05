require 'pg'
class Database
  def initialize database, username
    @database = database
    @username = username
    @connection ||= PG.connect :dbname => @database, :user => @username
  end
  def execute query
    @connection.exec query
  end
end
