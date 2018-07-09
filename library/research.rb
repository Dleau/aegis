module Research
  module Who
    # Returns hash of offender race totals
    # TODO
    def self.by_offender_race offenders

    end
    # Returns hash of victim race totals
    # TODO
    def self.by_victim_race offenders

    end 
    # Returns hash of offender age totals
    # TODO
    def self.by_offender_age offenders

    end
    # Returns hash of victim race totals
    # TODO
    def self.by_victim_age offenders

    end
  end
  module What

  end
  module When
    # Returns hash of incident totals by calendar week
    def self.by_week incidents
      hash = {}
      (0..53).each do |week|
        hash[week.to_s] = 0
      end
      incidents.each do |incident|
        week = Time.parse(incident['incident_date']).strftime('%W').to_i.to_s
	hash[week] = hash[week] + 1 if week.to_i >= 0 and week.to_i <= 53
      end
      hash.sort.to_h
    end
    # Returns hash of incident totals by calendar month
    def self.by_month incidents
      hash = {}
      (1..12).each do |month|
        hash[month.to_s] = 0
      end
      incidents.each do |incident|
        month = Time.parse(incident['incident_date']).strftime('%m').to_i.to_s
	hash[month] = hash[month] + 1 if month.to_i >= 1 and month.to_i <= 12
      end
      hash.sort.to_h
    end
  end
  module Where

  end
  module Why

  end
  module How

  end
end
