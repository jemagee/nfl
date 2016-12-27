# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

divisions = ["east", "north", "south", "west"]
conferences = ["nfc", "afc"]

conferences.each do |conference|
	divisions.each do |division|
		unless Division.exists?(conference: conference, name: division)
			Division.create(conference: conference, name: division)
		end
	end
end

nfc = {east: [{city: "Philadelphia", nickname:"Eagles", abbr: "PHI"},
							{city: "Washington", nickname: "Redskins", abbr: "WAS"},
							{city: "New York", nickname: "Giants", abbr: "NYG"},
							{city: "Dallas", nickname: "Cowboys", abbr: "DAL"}
	],
	south: [{city: "Atlanta", nickname: "Falcons", abbr: "ATL"},
							{city: "Carolina", nickname: "Panthers", abbr: "CAR"},
							{city: "Tampa Bay", nickname: "Buccaneers", abbr: "TB"},
							{city: "New Orleans", nickname: "Sains", abbr: "NO"}
	],
	north: [{city: "Green Bay", nickname: "Packers", abbr: "GB"},
							{city: "Chicago", nickname: "Bears", abbr: "CHI"},
							{city: "Detroit", nickname: "Lions", abbr: "DET"},
							{city: "Minneosta", nickname: "Vikings", abbr: "MIN"}
	],
	west: [{city: "Los Angeles", nickname: "Rams", abbr: "LA"},
						{city: "San Francisco", nickname: "49ers", abbr: "SF"},
						{city: "Arizona", nickname: "Cardinals", abbr: "ARI"},
						{city: "Seattle", nickname: "Seahawks", abbr: "SEA"}
	]}

afc = {east: [{city: "New England", nickname: "Patriots", abbr: "NE"},
							{city: "New York", nickname: "Jets", abbr: "NYJ"},
							{city: "Miami", nickname: "Dolphins", abbr: "MIA"},
							{city: "Buffalo", nickname: "Bills", abbr: "BUF"}
	],
	south: [{city: "Indianpolis", nickname: "Colts", abbr: "IND"},
							{city: "Houston", nickname: "Texans", abbr: "HOU"},
							{city: "Jacksonville", nickname: "Jaguars", abbr: "JAX"},
							{city: "Tennessee", nickname: "Titans", abbr: "TEN"}
	],
	north:  [{city: "Pittsburgh", nickname: "Steelers", abbr: "PIT"},
							{city: "Baltimore", nickname: "Ravens", abbr: "BAL"},
							{city: "Cleveland", nickname: "Browns", abbr: "CLE"},
							{city: "Cincinnati", nickname: "Bengals", abbr: "CIN"}
	],
	west: [{city: "Denver", nickname: "Broncos", abbr: "DEN"},
						{city: "San Diego", nickname: "Chargers", abbr: "SD"},
						{city: "Oakland", nickname: "Raiders", abbr: "OAK"},
						{city: "Kansas City", nickname: "Chiefs", abbr: "KC"}
	]}



afc.each do |key, value|
	conference = "afc"
	division = "#{key}"
	#team_division = Division.find(conference: conference, division: division)
	value.each do |info|
		unless Team.exists?(abbr: info[:abbr])
			Team.create(city: info[:city], abbr: info[:abbr], nickname: info[:nickname], division: Division.find_by(conference: conference, name: division))
		end
	end
end

nfc.each do |key, value|
	conference = "nfc"
	division = "#{key}"
	#team_division = Division.find(conference: conference, division: division)
	value.each do |info|
		unless Team.exists?(abbr: info[:abbr])
			Team.create(city: info[:city], abbr: info[:abbr], nickname: info[:nickname], division: Division.find_by(conference: conference, name: division))
		end
	end
end