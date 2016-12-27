require 'rails_helper'

RSpec.describe Game, type: :model do
  it {should validate_presence_of(:gamedate)}
  it {should validate_presence_of(:nflcomid)}
  it {should validate_uniqueness_of(:nflcomid).case_insensitive}
  it {should validate_numericality_of(:nflcomid).only_integer}
  it {should have_many(:participants)}
end
