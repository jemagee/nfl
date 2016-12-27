class Division < ApplicationRecord

	has_many :teams
	
	validates :name, presence: true, uniqueness: {scope: :conference, case_sensitive: false}
	validates :conference, presence: true, inclusion: {in: %w(nfc afc)}

	scope :afc, -> {where(conference: 'afc')}
	scope :nfc, -> {where(conference: 'nfc')}
	scope :east, -> {where(name: 'east')}
	scope :west, -> {where(name: 'west')}
	scope :south, -> {where(name: 'south')}
	scope :north, -> {where(name: 'north')}

end
