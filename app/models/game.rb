class Game < ApplicationRecord

	require 'Nokogiri'

	has_many :participants
	has_many :passing_statistics, through: :participants

	validates :gamedate, presence: true
	validates :nflcomid, presence: true, uniqueness: {case_sensitive: false}, numericality: {only_integer: true}

	def self.get_games(year, week)
		source = Nokogiri::HTML(open("http://www.nfl.com/schedules/#{year}/REG#{week}"))
		games = source.css("a.gc-btn")
		games.each do |game|
			href = game["href"]
			gameid = href.scan(/\/(\d+)\//)[0][0]
			year = gameid[0..3].to_i
			month = gameid[4..5].to_i
			day = gameid[6..7].to_i
			gamedate = Date.new(year,month,day)
			Game.create(gamedate: gamedate, nflcomid: gameid)
		end
	end
end
