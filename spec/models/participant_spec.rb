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
    it {should validate_presence_of(:ot)}
    it {should validate_inclusion_of(:homeaway).in_array(["H", "A"])}
    it {should validate_inclusion_of(:winlosstie).in_array(["W", "L", "T"])}
    it {should validate_numericality_of(:q1).only_integer}
    it {should validate_numericality_of(:q2).only_integer}
    it {should validate_numericality_of(:q3).only_integer}
    it {should validate_numericality_of(:q4).only_integer}
    it {should validate_numericality_of(:ot).only_integer}
  end

  describe "Verifying scope of team within game" do

    it "should not allow the same team to be entered as a participant for the same game" do
      Participant.create(team: Team.first, game: game, homeaway: "H", winlosstie: "W", q1: 7, q2: 10, q3: 14, q4: 10, ot: 0)
      test = Participant.create(team: Team.first, game: game, homeaway: "H", winlosstie: "W", q1: 7, q2: 10, q3: 14, q4: 10, ot: 0)
      expect(test.errors.full_messages).to include("Team has already been taken")
      expect(test.valid?).to eq false
    end
  end
end
