class Game < ApplicationRecord

	validates :gamedate, presence: true
	validates :nflcomid, presence: true, uniqueness: {case_sensitive: false}, numericality: {only_integer: true}
end
