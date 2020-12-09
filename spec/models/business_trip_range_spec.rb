require 'rails_helper'

RSpec.describe BusinessTripRange, type: :model do
  describe "build BusinessTripRange" do
    before do
      @business_trip_range = build(:business_trip_range)
    end
    it "有効な" do
      @business_trip_range.masseur_id = nil
      expect(@business_trip_range).to be_valid
    end
    context "masseur_idがなかった時" do
      it "無効である" do
        @business_trip_range.masseur_id = nil
        expect(@business_trip_range).to be_valid
      end
    end
    context "city_idがなかった時" do
      it "無効である" do
        @business_trip_range.city_id = nil
        expect(@business_trip_range).to be_valid
      end
    end
  end
end
