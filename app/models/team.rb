class Team < ApplicationRecord
  belongs_to :division

  has_many :participants

  validates :abbr, presence: true, length: {in: 2..3}, uniqueness: {case_sensitive: false}
  validates :nickname, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 4}
  validates :city, presence: true
  validates :division, presence: true
end
