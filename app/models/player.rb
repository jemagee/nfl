class Player < ApplicationRecord

	validates :name, presence: true
	validates :oldid, presence: true, uniqueness:true
	validates :nflcomid, presence: true, numericality: {only_integer: true}, uniqueness: true
	validates :height, presence: true, numericality: {only_integer: true}
	validates :birth_date, presence: true
	validates :college, presence: true
	validates :draft_year, :draft_round, :round_pick, :overall_pick, presence: true, numericality: {only_integer: true}
	validates :round_pick, uniqueness: {scope: [:draft_year, :draft_round]}

	def self.add_player(oldnumber, data)
		source_data = Nokogiri::HTML(open(data))
		new_player = Player.new
		new_player.name = source_data.at('meta[id="playerName"]')["content"]
		new_player.oldid = oldnumber
		new_player.nflcomid = source_data.at('link[rel="canonical"]')["href"].scan(/\d+/).last.to_i

		new_player_information = source_data.css('div.player-info').css("strong")

		traits = {}

		new_player_information.each do |trait|
			traits[trait.content.downcase] = trait.next.content
		end

		new_player.college = traits["college"][2..-1]
		new_player.height = get_height(traits["height"].scan(/\d-\d/))
		new_player.birth_date =  Date.strptime(traits["born"].scan(/\d*\/\d*\/\d*/)[0], '%m/%d/%Y')
		new_player.draft_year = source_data.css('.draft-header').text.split(" ").last.to_i
		new_player.draft_round = source_data.css('span.round').text.to_i
		teamname = source_data.css('span.team').text.split(" ").last
		new_player.draft_team = Team.find_by('nickname like ?', "%#{teamname}").id

		picks = source_data.css('div#pick-overview p').last.text.scan(/(\d+)/)
		new_player.round_pick = picks[0][0].to_i
		new_player.overall_pick = picks[1][0].to_i
		new_player.save

	end

	private

    def self.get_height(player_height)
	    feet = player_height[0][0].to_i * 12
	    inches = player_height[0][2].to_i
	    feet + inches
    end
end
