require 'db_connection'
include DBConnection

describe DBConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')

      DBConnection.setup('bookmark_manager_test')
    end
  end

  it 'this connection is persistent' do
    # Grab the connection as a return value from the .setup method
    connection = DBConnection.setup('bookmark_manager_test')

    expect(DBConnection.connection).to eq connection
  end
  describe '.query' do
    it 'executes a query via PG' do
      connection = DBConnection.setup('bookmark_manager_test')

      expect(connection).to receive(:exec).with("SELECT * FROM bookmarks;")

      DBConnection.query("SELECT * FROM bookmarks;")
    end
  end
end
