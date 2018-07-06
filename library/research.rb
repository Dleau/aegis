module Research
  module Incidents
    # Returns the number of incidents occuring
    # during each calendar week
    def self.weekly incidents
      hash = {}
      (0..52).each do |week|
        hash[week.to_s] = 0
      end
      incidents.each do |incident|
	week = Time.parse(incident['incident_date']).strftime('%W').to_i.to_s
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
