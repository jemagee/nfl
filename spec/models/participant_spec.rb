require 'rails_helper'

RSpec.describe Participant, type: :model do

  let!(:game) {FactoryGirl.create(:game)}


  describe "Shoulda-matcher Work" do

    it {should belong_to(:team)}
    it {should belong_to(:game)}
    it {should validate_presence_of(:game)}
    it {should validate_presence_of(:team)}
    it {should validate_presence_of(:winlosstie)}
    it {should validate_presence_of(:homeaway)}
    it {should validate_presence_of(:q1)}
    it {should validate_presence_of(:q2)}
    it {should validate_presence_of(:q3)}
    it {should validate_presence_of(:q4)}
    it {should validate_presence_of(:q5)}
    it {should validate_inclusion_of(:homeaway).in_array(["H", "A"])}
    it {should validate_inclusion_of(:winlosstie).in_array(["W", "L", "T"])}
    it {should validate_numericality_of(:q1).only_integer}
    it {should validate_numericality_of(:q2).only_integer}
    it {should validate_numericality_of(:q3).only_integer}
    it {should validate_numericality_of(:q4).only_integer}
    it {should validate_numericality_of(:q5).only_integer}
  end

  describe "Verifying scope of team within game" do

    Rails.application.load_seed

    it "should not allow the same team to be entered as a participant for the same game" do
      Participant.create(team: Team.first, game: game, homeaway: "H", winlosstie: "W", q1: 7, q2: 10, q3: 14, q4: 10, q5: 0)
      test = Participant.create(team: Team.first, game: game, homeaway: "H", winlosstie: "W", q1: 7, q2: 10, q3: 14, q4: 10, q5: 0)
      expect(test.errors.full_messages).to include("Team has already been taken")
      expect(test.valid?).to eq false
    end
  end

  context "The JSON captured by the gameID will populate participants correctly" do

    before do
      Game.add_games('spec/fixtures/nokogiritest.html')
      Participant.add_participants(JSON.parse(File.read('spec/fixtures/participanttest.json')))
    end

    it "should create two records" do
      expect(Participant.count).to eq 2
    end

    it "should have one winner and one loser" do
      expect(Participant.where(winlosstie: "W").count).to eq 1
      expect(Participant.where(winlosstie: "L").count).to eq 1
    end

    it "should have a home team equal to the Broncos" do
      expect(Participant.find_by(homeaway: "H").team.nickname).to eq "Broncos"
    end

    it "should have an away team equal to the Panthers" do
      expect(Participant.find_by(homeaway: "A").team.nickname).to eq "Panthers"
    end


    it "should have a winner with 21 Points" do
      expect(Game.find_by(nflcomid: 2016090800).participants.winner.points).to equal(21)
    end

    it "should have a loser with 20 points" do
      expect(Game.find_by(nflcomid: 2016090800).participants.loser.points).to equal(20)
    end
  end
end
