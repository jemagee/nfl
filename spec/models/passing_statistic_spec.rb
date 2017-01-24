require 'rails_helper'

RSpec.describe PassingStatistic, type: :model do
  it{should belong_to(:participant)}
  it{should belong_to(:player)}
  it{should validate_presence_of(:att)}
  it{should validate_presence_of(:cmp)}
  it{should validate_presence_of(:yds)}
  it{should validate_presence_of(:tds)}
  it{should validate_presence_of(:ints)}
  it{should validate_presence_of(:twoptm)}
  it{should validate_presence_of(:twopta)}	
  it{should validate_numericality_of(:att).only_integer}
  it{should validate_numericality_of(:cmp).only_integer}
  it{should validate_numericality_of(:yds).only_integer}
  it{should validate_numericality_of(:tds).only_integer}
  it{should validate_numericality_of(:ints).only_integer}
  it{should validate_numericality_of(:twoptm).only_integer}
  it{should validate_numericality_of(:twopta).only_integer}

  context "Processing the passing statistic from the source json" do

  	before { PassingStatistic.get_stats(File.read("spec/fixtures/participanttest.json"))}

  	it "should change the passing statistics by two" do
  		expect(PassingStatistic.count).to equal 2
  	end
  end
end
