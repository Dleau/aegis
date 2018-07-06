require_relative '../library/import'

print 'Dropping a database?: '
drop_db = gets.chomp
`sudo -u postgres dropdb #{drop_db}` if drop_db.length > 0

print 'Inbound database state: '
db_state = gets.chomp
print 'Inbound database year: '
db_year = gets.chomp

i = Import.new db_state, db_year
i.import
