require 'rails_helper'

RSpec.describe FavoriteStore, type: :model do
  describe "FavoriteStore" do
    before do
      @favorite_store = build(:favorite_store)
    end
    context "user_idがnilの場合" do
      it "無効である事" do
        @favorite_store.user_id = nil
        expect(@favorite_store).to be_invalid
      end
    end
    context "store_idがnilの場合" do
      it "無効である事" do
        @favorite_store.store_id = nil
        expect(@favorite_store).to be_invalid
      end
    end
  end
end
