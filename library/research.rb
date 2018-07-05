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
end
