require_relative '../library/database.rb'
require_relative '../library/queries.rb'
require_relative '../library/import.rb'
require_relative '../library/research.rb'
require_relative '../library/dictionary.rb'

require 'googlecharts'

# Compare weekly incident totals in each agency for each offense code
# to the cooresponding statistic of the database state and graph
def get_weekly_totals
  database = Database.new 'RI-2016', 'postgres'
  Dictionary.offense_codes.each do |code, offense|
    # Obtain state data for this offense
    puts "Querying state-wide dataset for #{offense}"
    state_query = Queries::Incidents.state_with_code code
    state_data  = database.execute state_query
    state_weekly_data = Research::When.by_week state_data
    # Create a weekly dataset
    puts "Populating a state-wide weekly dataset"
    state_weekly_array = []
    state_weekly_data.each do |week, value|
      state_weekly_array.append value
    end
    # Obtain data from each agency for comparison
    agencies_query = Queries::Agencies.all
    agencies_data = database.execute agencies_query
    agencies_data.each do |agency|
      next if agency['nibrs_reported'].to_i == 0
      puts "Querying #{agency['agency_name']} dataset for #{offense}"
      agency_query = Queries::Incidents.agency_with_code agency['agency_ori'], code
      agency_data = database.execute agency_query
      agency_weekly_data = Research::When.by_week agency_data
      # Create a weekly dataset
      puts "Populating a weekly dataset"
      agency_weekly_array = []
      agency_weekly_data.each do |week, value|
        agency_weekly_array.append value
      end
      # Create graph
      file = "out/#{database.database}_#{agency['agency_name']}_#{code}.png"
      puts "Creating comparison graph and saving to #{file}"
      g = Gchart.new(
        type: 'line',
        title: "Counts of #{offense} by calendar week",
        data: [state_weekly_array, agency_weekly_array],
        legend: ["#{database.database}", "#{agency['agency_name']}"],
	line_colors: ['1565c0', 'c62828'],
        axis_with_labels: ['x', 'y'],
        axis_range: [[0, 53, 53 / 10], [0, state_weekly_array.max, state_weekly_array.max / 10]],
        size: '500x500',
        filename: file
      )
      g.file
    end
  end
end
get_weekly_totals
