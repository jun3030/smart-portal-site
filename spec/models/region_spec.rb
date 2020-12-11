require 'rails_helper'

RSpec.describe Region, type: :model do
  before do
    @region = Region.new
  end
  it "有効な地区であること" do
    expect(@region).to be_valid
  end
end
