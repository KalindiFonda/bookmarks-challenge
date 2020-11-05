

require 'pg'

module DBConnection
  def self.exec(sql_query)
    begin
      if ENV['RACK_ENV'] == 'test'
        connection = PG.connect(dbname: 'bookmark_manager_test')
      else
        connection = PG.connect(dbname: 'bookmark_manager')
      end
      connection.exec(sql_query)
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end

  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end
  
end
