class Division < ApplicationRecord

	validates :name, presence: true, uniqueness: {scope: :conference, case_sensitive: false}
	validates :conference, presence: true, inclusion: {in: %w(nfc afc)}
end
