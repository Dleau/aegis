require_relative '../library/database.rb'
require_relative '../library/queries.rb'
require_relative '../library/import.rb'
require_relative '../library/research.rb'
require_relative '../library/dictionary.rb'

require 'googlecharts'

# Compare state-wide offender race totals to those of the state
def get_offender_races
  database = Database.new 'RI-2016', 'postgres'
  Dictionary.offense_codes.each do |code, offense|
    agencies = database.execute Queries::Agencies.all
    agencies.each do |agency|
      next if agency['nibrs_reported'].to_i == 0
      puts "Gathering offender race data for #{offense} in #{agency['agency_name']}"
      data = {}; races = []
      Dictionary.race_ids.collect {|key, val| data[key] = 0; races.append val}
      query = Queries::Incidents.agency_with_code agency['agency_ori'], code
      incident_ids = collect_ids(database.execute query)
      incident_ids.each do |incident_id|
        query = Queries::Offender.offenders incident_id
	offenders = database.execute query
	offenders.each do |offender|
          race_id = offender['race_id']
	  data[race_id.to_sym] = data[race_id.to_sym] + 1 if race_id != nil     
        end
      end
      file = "out/#{database.database}_#{agency['agency_name']}_#{code}.png"
      puts "Creating graph and saving to #{file}"
      g = Gchart.new(
	type: 'bar',
        title: "Races of #{offense} offenders",
	data: [data.values],
	axis_labels: [data.keys],
	axis_with_labels: ['x', 'y'],
	axis_range: [nil, [0, data.values.max, data.values.max / 10]],
	size: '500x500',
	filename: file
      )
      g.file
    end
  end
end

def collect_ids incidents
  ids = []
  incidents.each do |incident|
    ids.append incident['incident_id']
  end
  ids
end

get_offender_races

# 83974010

