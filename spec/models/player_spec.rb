require 'rails_helper'

RSpec.describe Player, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:oldid)}
  it {should validate_uniqueness_of(:oldid)}
  it {should validate_presence_of(:nflcomid)}
  it {should validate_uniqueness_of(:nflcomid)}
  it {should validate_numericality_of(:nflcomid).only_integer}
  it {should validate_presence_of(:height)}
  it {should validate_numericality_of(:height).only_integer}
  it {should validate_presence_of(:birth_date)}
  it {should validate_presence_of(:college)}
  it {should validate_numericality_of(:draft_year).only_integer}
  it {should validate_numericality_of(:draft_round).only_integer}
  it {should validate_numericality_of(:round_pick).only_integer}
  it {should validate_uniqueness_of(:round_pick).scoped_to([:draft_year, :draft_round])}
  it {should validate_numericality_of(:overall_pick).only_integer}
  it {should validate_uniqueness_of(:overall_pick).scoped_to([:draft_year])}
  it {should have_many(:passing_statistics)}

  it "should change the player count by 1" do
  	expect{Player.add_player('spec/fixtures/player_information_test.html')}.to change{Player.count}.by(1)
    expect(Player.all.count).to equal 1
  end

  context "The method for adding players should parse the information properly to store the proper information" do

  	before do
      player = instance_double("Player")
      allow(player).to receive(:get_raw_draft).and_return(true)
      Player.add_player('spec/fixtures/player_information_test.html')
    end

    it "should have player name of Trevor Siemian" do
      expect(Player.first.name).to eq "Trevor Siemian"
    end

    it "should have the right nflcomid" do
      expect(Player.first.nflcomid).to eq 2553457
    end

    it "should have the right old id" do
      expect(Player.first.oldid).to eq "00-0032156"
    end

    it "shouuld have the right height value" do
      expect(Player.first.height).to eq 75
    end

    it "should have the right birth date" do
      expect(Player.first.birth_date.year).to eq 1991
      expect(Player.first.birth_date.month).to eq 12
      expect(Player.first.birth_date.day).to eq 26
    end

    it "should have the right college" do
      expect(Player.first.college).to eq "Northwestern"
    end

    context "The player draft information should be added properly separately, but identify the regular player" do

      let!(:player) {Player.first}

      before do
        player.draft_information(Nokogiri::HTML(open('spec/fixtures/player_draft.html')))
      end

      it "should have player round of 7" do
        expect(Player.first.draft_round).to eq 7
      end

      it "should have a player draft year of 2015" do
        expect(Player.first.draft_year).to eq 2015
      end

      it "should have the right draft round pick" do
        expect(Player.first.round_pick).to eq 33
      end

      it "should have the right overall pick" do
        expect(Player.first.overall_pick).to eq 250
      end

      it "should have the right draft_team" do
        expect(Player.first.draft_team).to eq (Team.find_by(abbr: "DEN").id)
      end
    end

    it "should change the player count by 1 for an undrafted player" do
      expect{Player.add_player('spec/fixtures/undrafted_player_test.html')}.to change{Player.count}.by(1)
    end

    context "Adding a player with now draft information should work properly" do
      before do
        Player.add_player('spec/fixtures/undrafted_player_test.html')
      end

      it "should have no draft team" do
        expect(Player.find_by(nflcomid: 2556585).draft_team).to eq nil
      end
    end

    context "Adding a player with zero inches in height should work properly" do
      before {Player.add_player('spec/fixtures/player_test_zero_inches.html')}

      it "should have a player height of 72" do
        expect(Player.find_by(nflcomid: 2504775).height).to eq 72
      end
    end

    context "Adding a player with double digit inches in hight should work properly" do
      before {Player.add_player('spec/fixtures/player_test_double_digit_inches.html')}

      it "should have a player height of 71" do
        expect(Player.find_by(nflcomid: 2507597).height).to eq 70
      end
    end
  end		
end
