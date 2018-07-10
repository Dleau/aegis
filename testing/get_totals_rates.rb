require_relative '../library/database.rb'
require_relative '../library/queries.rb'
require_relative '../library/dictionary.rb'

require 'terminal-table'

# Obtain offense rates and totals for each agency
def get_totals_rates
  database = Database.new 'RI-2016', 'postgres'
  agencies = database.execute Queries::Agencies.all
  agencies.each do |agency|
    table = Terminal::Table.new do |t|
      t << [agency['agency_name']]
      t << :separator
      t << ['Offense', 'Agency count', 'State count', 'Agency rate', 'State rate']
      t << :separator
      Dictionary.offense_codes.each do |code, offense|
        state_incidents = database.execute(Queries::Incidents.state_with_code code)
        state_population = 1000 #TODO
        state_rate = 10000 * count(state_incidents) / state_population.to_f
        agency_incidents = database.execute(Queries::Incidents.agency_with_code agency['agency_ori'], code)
 	agency_population = 100#TODO 
        agency_rate = 10000 * count(agency_incidents) / agency_population.to_f
 	t << [offense, count(agency_incidents), count(state_incidents), agency_rate, state_rate]
      end
    end
    puts table
  end
end

def count results
  count = 0
  results.each do |result|
    count = count + 1
  end
  count
end

get_totals_rates
