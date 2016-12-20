require 'rails_helper'

RSpec.describe Team, type: :model do
  it {should belong_to(:division)}
  it {should validate_presence_of(:abbr)}
  it {should validate_length_of(:abbr).is_at_least(2).is_at_most(3)}
  it {should validate_uniqueness_of(:abbr).case_insensitive}
  it {should validate_presence_of(:nickname)}
  it {should validate_presence_of(:city)}
  it {should validate_uniqueness_of(:nickname).case_insensitive}
  it {should validate_length_of(:nickname).is_at_least(4)}
end
