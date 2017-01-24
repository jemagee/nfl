class Player < ApplicationRecord

	has_many :passing_statistics

	validates :name, presence: true
	validates :oldid, presence: true, uniqueness:true
	validates :nflcomid, presence: true, numericality: {only_integer: true}, uniqueness: true
	validates :height, presence: true, numericality: {only_integer: true}
	validates :birth_date, presence: true
	validates :college, presence: true
	validates :draft_year, :draft_round, :round_pick, :overall_pick, numericality: {only_integer: true}
	validates :round_pick, uniqueness: {scope: [:draft_year, :draft_round]}
	validates :overall_pick, uniqueness: {scope: :draft_year}

	def self.add_player(data)
		source_data = Nokogiri::HTML(open(data))
		new_player = Player.new
		new_player.name = source_data.at('meta[id="playerName"]')["content"]
		new_player.oldid = source_data.to_s.scan(/GSIS ID:\W\w+\W\w+/).to_s.scan(/\d+-\d+/)[0]
		new_player.nflcomid = source_data.at('link[rel="canonical"]')["href"].scan(/\d+/).last.to_i

		new_player_information = source_data.css('div.player-info').css("strong")

		traits = {}

		new_player_information.each do |trait|
			traits[trait.content.downcase] = trait.next.content
		end

		new_player.college = traits["college"][2..-1]
		new_player.height = get_height(traits["height"].scan(/\d-\d+/)[0])
		new_player.birth_date =  Date.strptime(traits["born"].scan(/\d*\/\d*\/\d*/)[0], '%m/%d/%Y')
		new_player.save
		if source_data.css("div#player-profile-tabs a").to_s.downcase.include?("draft")
			draft_link = source_data.at('link[rel="canonical"]')["href"].sub!("profile", "draft")
			raw_draft = new_player.get_raw_draft(draft_link)
			new_player.draft_information(raw_draft)
		end
	end

  def get_raw_draft(link)
  	Nokogiri::HTML(open(link))
  end

  def draft_information(data)
  	source_data = data
    self.draft_year = source_data.css('.draft-header').text.split(" ").last.to_i
		self.draft_round = source_data.css('span.round').text.to_i
		teamname = source_data.css('span.team').text.split(" ").last
		self.draft_team = Team.find_by('nickname like ?', "%#{teamname}").id

		picks = source_data.css('div#pick-overview p').last.text.scan(/(\d+)/)
		self.round_pick = picks[0][0].to_i
		self.overall_pick = picks[1][0].to_i
		self.save
	end

	private

    def self.get_height(player_height)
	    feet = player_height.split("-")[0].to_i * 12
	    inches = player_height.split("-")[1].to_i
	    feet + inches
    end



end
