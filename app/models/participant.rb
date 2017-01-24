class Participant < ApplicationRecord
  belongs_to :game
  belongs_to :team
  has_many :passing_statistics

  validates :game, presence: true
  validates :team, presence: true, uniqueness: {scope: :game}
  validates :winlosstie, presence: true, inclusion: {in: %w(W L T)}
  validates :homeaway, presence: true, inclusion: {in: %w(H A)}
  validates :q1, :q2, :q3, :q4, :q5, presence: true, numericality: {only_integer: true}

  scope :winner, -> {where(winlosstie: 'W')}
  scope :loser, -> {where(winlosstie: 'L')}

  def self.points
     total = 0
    # count = 1
    # while count <= 5
    #   total += pluck("q#{count}".to_s)[0]
    #   count += 1
    # end
    # return total.to_i
    pluck(:q1, :q2, :q3, :q4, :q5).each do |scoring|
      total += scoring.inject{|sum, n| sum + n}
    end
    return total
  end



  def self.add_participants(gameinfo) 
  	rawgame = gameinfo.keys.first
  	gameid = Game.find_by(nflcomid: rawgame.to_i)
  	homehash = gameinfo[rawgame]["home"]
  	awayhash = gameinfo[rawgame]["away"]
  	homescore = homehash["score"]
  	awayscore = awayhash["score"]
    #binding.pry
  	hometotal = homescore["T"]
  	awaytotal = awayscore["T"]
  	hometeam = Participant.new(homeaway: "H", game: gameid)
  	hometeam.team = Team.find_by(abbr: homehash["abbr"])
  	homescore.each do |key, value|
  		unless key == "T"
  			key = "q#{key}".to_s
  			hometeam[key] = value
  		end
  	end
  	awayteam = Participant.new(homeaway: "A", game: gameid)
  	awayteam.team = Team.find_by(abbr: awayhash["abbr"])
  	awayscore.each do |key, value|
  		unless key == "T"
  			key = "q#{key}".to_s
  			awayteam[key] = value
  		end
  	end
  	if awaytotal === hometotal
  		hometeam.winlosstie = "T"
  		awayteam.winlosstie = "T"
  	else 
  		if awaytotal > hometotal
  			hometeam.winlosstie = "L"
  			awayteam.winlosstie = "W"
  		else
  			hometeam.winlosstie = "W"
  			awayteam.winlosstie = "L"
  		end
  	end
  	hometeam.save
  	awayteam.save
  end

end
