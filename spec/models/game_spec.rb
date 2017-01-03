require 'rails_helper'

RSpec.describe Game, type: :model do


  it {should validate_presence_of(:gamedate)}
  it {should validate_presence_of(:nflcomid)}
  it {should validate_uniqueness_of(:nflcomid).case_insensitive}
  it {should validate_numericality_of(:nflcomid).only_integer}
  it {should have_many(:participants)}

  scenario "Nokogiri will successfully populate the game and date information" do

  	expect{Game.add_games('spec/fixtures/nokogiritest.html')}.to change{Game.count}.by(16)
  end
end
