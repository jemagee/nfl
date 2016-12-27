class Participant < ApplicationRecord
  belongs_to :game
  belongs_to :team

  validates :game, presence: true
  validates :team, presence: true, uniqueness: {scope: :game}
  validates :winlosstie, presence: true, inclusion: {in: %w(W L T)}
  validates :homeaway, presence: true, inclusion: {in: %w(H A)}
  validates :q1, :q2, :q3, :q4, :ot, presence: true, numericality: {only_integer: true}
end
