class PassingStatistic < ApplicationRecord
  belongs_to :player
  belongs_to :participant
  validates :att, :cmp, :yds, :tds, :ints, :twopta, :twoptm, presence: true, numericality: {only_integer: true}

  def self.get_stats(source)
  	source_data = JSON.parse(source)
  	home_stats = source_data[source_data.keys.first]["home"]["stats"]["passing"]
  	away_stats = source_data[source_data.keys.first]["away"]["stats"]["passing"]
  	
  end

end
