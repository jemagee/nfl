class Player < ApplicationRecord

	validates :name, presence: true
	validates :oldid, presence: true
	validates :nflcomid, presence: true, numericality: {only_integer: true}
	validates :height, presence: true, numericality: {only_integer: true}
	validates :birth_date, presence: true
	validates :college, presence: true
	validates :draft_year, :draft_round, :round_pick, :overall_pick, presence: true, numericality: {only_integer: true}
end
