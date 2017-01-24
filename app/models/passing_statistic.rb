class PassingStatistic < ApplicationRecord
  belongs_to :player
  belongs_to :participant
  validates :att, :cmp, :yds, :tds, :ints, :twopta, :twoptm, presence: true, numericality: {only_integer: true}
end
