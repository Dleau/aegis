require_relative '../library/database.rb'
require_relative '../library/queries.rb'
require_relative '../library/dictionary.rb'

# Obtain offense rates and totals for each agency
# TODO determine PG result size and calculate agency and state populations
def get_totals_rates
  database = Database.new 'RI-2016', 'postgres'
  agencies = database.execute Queries::Agencies.all
  agencies.each do |agency|
    puts agency['agency_name']
    puts "Offense\t\tAgency count\t\tAgency rate\t\tState count\t\tState rate"
    Dictionary.offense_codes.each do |code, offense|
      state_incidents = database.execute(Queries::Incidents.state_with_code code)
      state_population = 0 #TODO
      state_rate = 10000 * state_incidents.length / state_population.to_f
      agency_incidents = database.execute(Queries::Incidents.agency_with_code agency['agency_ori'], code)
      agency_population = 0 #TODO
      agency_rate = 10000 * agency_incidents.length / agency_population.to_f
      row = "#{offense}\t\t#{agency_incidents.length}" + 
	    "\t\t#{agency_rate}\t\t#{state_incidents.length}\t\t#{state_rate}"
    end
  end
end
get_totals_rates
