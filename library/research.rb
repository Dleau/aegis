module Research
  module Incidents
    # Returns the number of incidents occuring
    # during each calendar week
    def self.weekly incidents
      hash = {}
      incidents.each do |incident|
	week = Time.parse(incident['incident_date']).strftime('%W')
	hash[week] = 0 if hash[week] == nil
	hash[week] = hash[week] + 1
      end
      hash.sort.to_h
    end
  end
  module Offenses
   
  end
  module Agencies

  end
  module Database
    # Returns an approximate number of rows in the database
    def self.row_count tables
      total = 0
      tables.each do |table|
        total = total + table['n_live_tup'].to_i
      end
      total
    end
    # Returns an approximate number of columns in the database
    def self.column_count count
      count[0]['count'].to_i
    end
  end
end
