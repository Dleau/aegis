require 'open-uri'
BASE = 'http://s3-us-gov-west-1.amazonaws.com/cg-d3f0433b-a53e-4934-8b94-c678aa2cbaf3/'
class Import
  def initialize state, year
    @state = state
    @year = year
    @database = "#{@state}-#{@year}"
  end
  def download
    puts 'Downloading zip from source'
    IO.copy_stream open("#{BASE}#{@year}/#{@database}.zip"), "#{@database}.zip"
  end
  def install
    puts 'Extracting tables from zip'
    `unzip #{@database}.zip -d #{@database}`
    Dir.chdir @database
    puts 'Preparing postgesql for installation'
    `sudo -u postgres dropdb #{@database}`
    `sudo -u postgres createdb #{@database}`
    puts 'Installing database'
    `sudo -u postgres psql #{@database} < postgres_setup.sql`
    `sudo -u postgres psql #{@database} < postgres_load.sql`
    puts 'Cleaning up'
    Dir.chdir '..'
    `rm -r #{@database} #{@database}.zip`
  end
  def import
    download
    install
  end
end
