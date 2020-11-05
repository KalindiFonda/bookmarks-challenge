require './lib/db_connection'

if ENV['ENVIRONMENT'] == 'test'
  DBConnection.setup('bookmark_manager_test')
else
  DBConnection.setup('bookmark_manager')
end
