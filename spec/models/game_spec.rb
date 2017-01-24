require 'rails_helper'

RSpec.describe Game, type: :model do


  it {should validate_presence_of(:gamedate)}
  it {should validate_presence_of(:nflcomid)}
  it {should validate_uniqueness_of(:nflcomid).case_insensitive}
  it {should validate_numericality_of(:nflcomid).only_integer}
  it {should have_many(:participants)}
  it {should have_many(:passing_statistics).through(:participants)}

  context "Nokogiri will successfully populate the game and date information" do

  	before do
      VCR.use_cassette "Get Games" do
        Game.get_games(2016, 1)
      end
    end

    after do
      VCR.eject_cassette
    end

  	it "inserts 16 new records" do
  		expect(Game.count).to equal(16)
  	end

  	it "inserts one game with the game date 9/8/2016" do
  		expect(Game.where(gamedate: "2016-09-08").count).to equal(1)
  	end

  	it "inserts two games with the game date 9/12/2016" do
  		expect(Game.where(gamedate: "2016-09-12").count).to equal(2)
  	end

  	it "inserts thirteen games with the game date 9/11/2016" do
  		expect(Game.where(gamedate: "2016-09-11").count).to equal(13)
  	end
  end
end
