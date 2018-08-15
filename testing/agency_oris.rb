require_relative '../library/database.rb'
require_relative '../library/queries.rb'
require_relative '../library/dictionary.rb'

DATABASE = Database.new 'RI-2016', 'postgres'

agencies = DATABASE.execute(Queries::Agencies.all)
agencies.each do |agency|
  puts agency['agency_name'] + ': ' + agency['agency_ori']
end
