module Queries
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
  module Offender
    # Obtains a list of all offenders associated with a provided
    # incident id
    def self.offenders incident_id
      "select o.*
      from nibrs_offender o
      where incident_id = '#{incident_id}'"
    end
  end
  module Agencies
    # Obtains a list of all agencies within the database state
    def self.all
      "select agency_ori, agency_name, nibrs_reported
      from agency_participation"
    end
    # Obtains a cde_agencies entry based on agency ori
    def self.agency ori
      "select a.*
      from cde_agencies a
      where ori = '#{ori}'"
    end
  end
  module Database
    # Obtains list of tables in database
    def self.tables
      "select relname
      from pg_stat_user_tables p
      order by p.relname"
    end
    # Obtains number of rows in supplied table
    def self.row_count table
      "select count(*)
      from #{table}"
    end
    # Obtains the number of columns in supplied table
    def self.column_count table
      "select count(*)
      from information_schema.columns
      where table_name = '#{table}'"
    end
  end
end
