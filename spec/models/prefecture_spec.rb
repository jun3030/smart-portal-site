require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  describe "Prefecture" do
    before do
      @prefecture = build(:prefecture)
    end
    it "有効な都道府県である" do
      expect(@prefecture).to be_valid
    end
    context "region_idがなかった時" do
      it "無効である" do
        @prefecture.region_id = nil
        expect(@prefecture).to be_invalid
      end
    end
  end
end
