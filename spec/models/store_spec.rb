require 'rails_helper'

RSpec.describe Store, type: :model do
  before do
    @store = build(:store)
  end

  it "有効なstoreを持つこと" do
    expect(@store).to be_valid
  end

  it "store_manager_idがなければ無効であること" do
    @store.store_manager_id = nil
    expect(@store).to be_invalid
  end

  describe 'stoer_name' do
    it "お店の名前がない場合は無効であること" do
      @store.store_name = nil
      expect(@store).to be_invalid
    end
  end

  describe 'adress' do
    it "住所が存在した際に4文字以下は無効であること" do
      @store.adress = "adre"
      expect(@store).to be_invalid
    end

    it "住所が存在した際に5文字以上は有効であること" do
      @store.adress = "adres"
      expect(@store).to be_valid
    end
  end

  describe 'store_description' do
    it "店舗説明が存在した際に9文字以下は無効であること" do
      @store.store_description = SecureRandom.alphanumeric(9)
      expect(@store).to be_invalid
    end

    it "店舗説明が存在した際に10文字以上の場合は有効であること" do
      @store.store_description = SecureRandom.alphanumeric(10)
      expect(@store).to be_valid
    end
  end
end
