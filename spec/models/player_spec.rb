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
  it {should validate_presence_of(:draft_year)}
  it {should validate_presence_of(:draft_round)}
  it {should validate_presence_of(:round_pick)}
  it {should validate_presence_of(:overall_pick)}
  it {should validate_numericality_of(:draft_year).only_integer}
  it {should validate_numericality_of(:draft_round).only_integer}
  it {should validate_numericality_of(:round_pick).only_integer}
  it {should validate_uniqueness_of(:round_pick).scoped_to([:draft_year, :draft_round])}
  it {should validate_numericality_of(:overall_pick).only_integer}

  it "should change the player count by 1" do

  	expect{Player.add_player("00-0032156",'spec/fixtures/player_draft.html')}.to change{Player.count}.by(1)
  end

  # context "Adding Player Information should work properly" do

  # 	before { Player.add_player('00-0032156','spec/fixtures/player_draft.html')}


  # end
  		
end
