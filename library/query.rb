module Query
  module Incidents
    # Obtains hash list of incident headers for incidents
    # occuring within database state and during database year
    def self.state
      "select ni.* 
      from nibrs_incident ni"
    end
    # Obtains hash list of incident headers for incidents
    # occuring within specified ori and during database year
    def self.agency ori
      "select ni.* 
      from nibrs_incident ni
      join cde_agencies c on c.agency_id = ni.agency_id
      join agency_participation a on a.agency_ori = c.ori
      where a.agency_ori = '#{ori}'"
    end
  end
  module Offenses
    # Obtains hash list of offense headers for offenses
    # occuring within database state and during database year
    def self.state
      "select o.*
      from nibrs_offense o"
    end
    # Obtains a hash list of offense headers for offenses
    # occuring within database state and during database year
    # that contain the supplied offense code
    def self.state_with_code code
      "select o.*
      from nibrs_offense o
      join nibrs_offense_type ot on ot.offense_type_id = o.offense_type_id
      where ot.offense_code = '#{code}'"
    end
    # Obtains hash list of offense headers for offenses
    # occuring within specified ori and during database year
    def self.agency ori
      "select o.*
      from nibrs_offense o
      join nibrs_incident ni on o.incident_id = ni.incident_id
      join cde_agencies c on c.agency_id = ni.agency_id
      join agency_participation a on a.agency_ori = c.ori
      where a.agency_ori = '#{ori}'"
    end
    # Obtains a hash list of offense headers for offenses
    # occuring within specified ori and during database year
    # that contain the supplied offense code
    def self.agency_with_code ori, code
      "select o.*
      from nibrs_offense o
      join nibrs_offense_type ot on ot.offense_type_id = o.offense_type_id
      join nibrs_incident ni on o.incident_id = ni.incident_id
      join cde_agencies c on c.agency_id = ni.agency_id
      join agency_participation a on a.agency_ori = c.ori
      where a.agency_ori = '#{ori}'
      and ot.offense_code = '#{code}'"
    end
  end
end
