module Query
  module Incidents
    # Obtains hash list of incident headers for incidents
    # occuring within database state and during database year
    def self.state
      "select ni.* 
      from nibrs_incident ni"
    end
    # Obtains a hash list of incident headers for incidents
    # occuring within database state and during database year
    # of specified offense type
    def self.state_with_code code
      "select ni.*
      from nibrs_incident ni
      join nibrs_offense o on o.incident_id = ni.incident_id
      join nibrs_offense_type ot on ot.offense_type_id = o.offense_type_id
      where ot.offense_code = '#{code}'"
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
    # Obtains a hash list of incident headers for incidents
    # occuring within specified ori and during database year
    # of specified offense type
    def self.agency_with_code ori, code
      "select ni.*
      from nibrs_incident ni
      join nibrs_offense o on o.incident_id = ni.incident_id
      join nibrs_offense_type ot on ot.offense_type_id = o.offense_type_id
      join cde_agencies c on c.agency_id = ni.agency_id
      join agency_participation a on a.agency_ori = c.ori
      where a.agency_ori = '#{ori}'
      and ot.offense_code = '#{code}'"
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
  module Agencies
    # Obtains a list of all agencies within the database state
    def self.all
      "select agency_ori, agency_name, nibrs_reported
      from agency_participation"
    end
  end
  module Database
    # Obtains live row counts for all user tables in the database
    def self.rows
      "select schemaname, relname, n_live_tup
      from pg_stat_user_tables p
      order by p.n_live_tup desc"
    end
    def self.columns
      "select count(*) 
      from information_schema.columns
      where table_schema not in ('pg_catalog', 'information_schema')"
    end
  end
end
