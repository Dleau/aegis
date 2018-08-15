require_relative '../library/database.rb'
require_relative '../library/queries.rb'
require_relative '../library/dictionary.rb'

DATABASE = Database.new 'RI-2016', 'postgres'
ORI = 'RI0040900' # TODO determine with provided agency name

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

def generate_report
  report = {}
  agencies = DATABASE.execute(Queries::Agencies.all)
  Dictionary.offense_codes.each do |offense_code, offense_name|
    puts("Handling #{offense_name}")
    agency_count = count(DATABASE.execute(Queries::Incidents.agency_with_code(ORI, offense_code)))
    agency_rate = get_agency_rate(ORI, agency_count)
    state_count = count(DATABASE.execute(Queries::Incidents.state_with_code(offense_code)))
    state_rate = get_state_rate(agencies, state_count)
    multiplier = agency_rate / state_rate
    report[offense_name] = {:agency_count => agency_count, :agency_rate => agency_rate,
                            :state_count => state_count, :state_rate => state_rate,
                            :multiplier => multiplier}
  end
  report
end

generate_report.each do |offense, data|
  puts(offense)
  data.each do |key, value|
    puts(key.to_s + ': ' + value.to_s)
  end
  puts("\n")
end
