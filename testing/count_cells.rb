require_relative '../library/queries'
require_relative '../library/database'

database = Database.new 'MA-2016', 'postgres'
total_cells = 0

query = Queries::Database.tables
tables = database.execute query
tables.each do |table|
  table_name = table['relname']
  q = Queries::Database.row_count table_name
  row_count = database.execute(q)[0]['count']
  q = Queries::Database.column_count table_name
  column_count = database.execute(q)[0]['count']
  cell_count = row_count.to_i * column_count.to_i
  total_cells = total_cells + cell_count
end

def seperate_comma number
  number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
end

puts "There are #{seperate_comma total_cells} data points in database #{database.database}"
