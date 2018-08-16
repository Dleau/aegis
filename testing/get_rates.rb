require_relative '../library/database.rb'
require_relative '../library/queries.rb'
require_relative '../library/dictionary.rb'

require 'terminal-table'

DATABASE = Database.new 'RI-2016', 'postgres'

def get_agency_population ori
  query = Queries::Agencies.agency ori
  result = DATABASE.execute query
  return nil if result.first == nil
  result.first['population']
end

def get_state_population agencies
  state_population = 0
  agencies.each do |agency|
    ori = agency['agency_ori']
    population = get_agency_population ori
    next if population == nil
    state_population = state_population + population.to_i
  end  
  state_population
end

def get_agency_rate ori, count
  population = get_agency_population ori
  100000 * count / population.to_f
end

def get_state_rate agencies, count
  population = get_state_population agencies
  100000 * count / population.to_f
end

def count results
  count = 0
  results.each do |result|
    count = count + 1
  end
  count
end

def get_rates_by_offense
  Dictionary.offense_codes.each do |offense_code, offense_name|
    table = Terminal::Table.new do |table|
      table << ["#{offense_name}, #{offense_code}"]
      table << :separator
      table << ['Agency', 'Agency count', 'State count', 'Agency rate', 'State rate', '+/-']
      table << :separator
      num_state_incidents = count(DATABASE.execute(Queries::Incidents.state_with_code offense_code))
      agencies = DATABASE.execute Queries::Agencies.all
      state_rate = get_state_rate agencies, num_state_incidents
      agencies.each do |agency|
        name = agency['agency_name']
        ori = agency['agency_ori']
        num_agency_incidents = count(DATABASE.execute(Queries::Incidents.agency_with_code ori, offense_code))
        agency_rate = get_agency_rate ori, num_agency_incidents
	plus_minus = agency_rate - state_rate
	table << [name, num_agency_incidents, num_state_incidents, agency_rate, state_rate, plus_minus]
      end
    end  
    puts table
  end
end

def get_rates_by_agency
  # Establish local cache of state counts and rates
  cache = {}
  agencies = DATABASE.execute Queries::Agencies.all
  puts 'Caching statewide totals and rates...'
  Dictionary.offense_codes.each do |offense_code, offense_name|
    state_count = count(DATABASE.execute(Queries::Incidents.state_with_code offense_code))
    state_rate = get_state_rate agencies, state_count
    cache[offense_code] = {:count => state_count, :rate => state_rate}
  end
  agencies.each do |agency|
    name = agency['agency_name']
    ori = agency['agency_ori']
    table = Terminal::Table.new do |table|
      table << ["#{name}, #{ori}"]
      table << :separator
      table << ['Offense', 'Agency count', 'State count', 'Agency rate', 'State rate', '+/-']
      table << :separator
      Dictionary.offense_codes.each do |offense_code, offense_name|
        agency_count = count(DATABASE.execute(Queries::Incidents.agency_with_code ori, offense_code)) 
        state_count = cache[offense_code][:count]
        agency_rate = get_agency_rate ori, agency_count
        state_rate = cache[offense_code][:rate]
        plus_minus = agency_rate - state_rate
        table << [offense_name, agency_count, state_count, agency_rate, state_rate, plus_minus]
      end
    end
    puts table
  end
end

# get_rates_by_offense
get_rates_by_agency
