require 'rails_helper'

RSpec.describe City, type: :model do
  before do
    @city = build(:city)
  end
  it "有効な市であること" do
    expect(@city).to be_valid
  end
  context "prefecture_idがnilの場合" do
    it "無効であること" do
      @city.prefecture_id = nil
      expect(@city).to be_invalid
    end
  end
end
