class Player < ApplicationRecord

	validates :name, presence: true
	validates :oldid, presence: true, uniqueness:true
	validates :nflcomid, presence: true, numericality: {only_integer: true}, uniqueness: true
	validates :height, presence: true, numericality: {only_integer: true}
	validates :birth_date, presence: true
	validates :college, presence: true
	validates :draft_year, :draft_round, :round_pick, :overall_pick, presence: true, numericality: {only_integer: true}
	validates :round_pick, uniqueness: {scope: [:draft_year, :draft_round]}

	def self.add_player(data)
		source_data = Nokogiri::HTML(open(data))
		new_player = Player.new
		new_player.name = source_data.at('meta[id="playerName"]')["content"]
		new_player.oldid
		new_player.nflcomid = source_data.at('link[rel="canonical"]')["href"].scan('/\d+/').first.to_i

		new_player_information = source_data.css('div.player-info').css("strong")

		trait_scanning = {"height": /\d-\d/, "born": /\d*\/\d*\/\d*/}

		new_player_information.each do |trait|

		  if trait.content == ("Weight" || "Age" || "Experience" || "High School")
		  	next
		  end
			unless trait.content.downcase == ("height" || "born")
				new_player[trait.content.downcase] = trait.next
			end
		end
	end
end
