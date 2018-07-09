module Dictionary
  def self.offense_codes
    {'23*': 'Not Specified',
     '09C': 'Justifiable Homicide',
     '26A': 'False Pretenses/Swindle/Confidence Game',
     '36B': 'Statutory Rape',
     '11C': 'Sexual Assault With An Object',
     '290': 'Destruction/Damage/Vandalism of Property',
     '90F': 'Family Offenses',
     '23G': 'Theft of Motor Vehicle Parts or Accessories',
     '370': 'Pornography/Obscene Material',
     '39D': 'Sports Tampering',
     '90D': 'Driving Under the Influence',
     '250': 'Counterfeiting/Forgery',
     '26D': 'Welfare Fraud',
     '23A': 'Pocket-picking',
     '23F': 'Theft From Motor Vehicle',
     '40B': 'Assisting or Promoting Prostitution',
     '35A': 'Drug/Narcotic Violations',
     '26E': 'Wire Fraud',
     '23B': 'Purse-snatching',
     '90I': 'Runaway',
     '200': 'Arson',
     '240': 'Motor Vehicle Theft',
     '90E': 'Drunkenness',
     '23C': 'Shoplifting',
     '39B': 'Operating/Promoting/Assisting Gambling',
     '90A': 'Bad Checks',
     '210': 'Extortion/Blackmail',
     '13A': 'Aggravated Assault',
     '280': 'Stolen Property Offenses',
     '100': 'Kidnapping/Abduction',
     '40A': 'Prostitution',
     '39A': 'Betting/Wagering',
     '09A': 'Murder and Nonnegligent Manslaughter',
     '90H': 'Peeping Tom',
     '90J': 'Trespass of Real Property',
     '35B': 'Drug Equipment Violations',
     '11A': 'Rape',
     '270': 'Embezzlement',
     '09B': 'Negligent Manslaughter',
     '520': 'Weapon Law Violations',
     '120': 'Robbery',
     '26B': 'Credit Card/Automated Teller Machine Fraud',
     '90B': 'Curfew/Loitering/Vagrancy Violations',
     '11B': 'Sodomy',
     '13C': 'Intimidation',
     '23H': 'All Other Larceny',
     '26C': 'Impersonation',
     '23D': 'Theft From Building',
     '90Z': 'All Other Offenses',
     '220': 'Burglary/Breaking & Entering',
     '23E': 'Theft From Coin-Operated Machine or Device',
     '13B': 'Simple Assault',
     '90G': 'Liquor Law Violations',
     '90C': 'Disorderly Conduct',
     '39C': 'Gambling Equipment Violation',
     '36A': 'Incest',
     '11D': 'Fondling',
     '510': 'Bribery',
     '64A': 'Human Trafficking',
     '64B': 'Human Trafficking',
     '40C': 'Purchasing Prostitution',
     '26F': 'Identity Theft',
     '26G': 'Hacking/Computer Invasion',
     '720': 'Animal Cruelty'}
  end
  def self.race_ids
    {'0': 'Unknown',
    '1': 'White',
    '2': 'Black or African American',
    '3': 'American Indian or Alaska Native',
    '4': 'Asian',
    '5': 'Asian',
    '6': 'Chinese',
    '7': 'Japanese',
    '8': 'Native Hawaiian or Other Pacific Islander',
    '9': 'Other',
    '98': 'Multiple',
    '99': 'Not Specified'}
  end
end

# s = '{'
# File.readlines('../../RI-2016/nibrs_offense_type.csv').each do |line|
#   a = line.split(',')
#   s = s + "'#{a[1]}': '#{a[2]}',\n " 
# end
# s = s + '}'
# puts s
