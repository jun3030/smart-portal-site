require 'rails_helper'

RSpec.describe Plan, type: :model do
  before do
    @plan = build(:plan)
  end

  it "有効なplanを持つこと" do
    expect(@plan).to be_valid
  end

  it "store_idがなければ無効であること" do
    @plan.store_id = nil
    expect(@plan).to be_invalid
  end

  describe 'plan_name' do
    it "プラン名が無い場合、無効であること" do
      @plan.plan_name = nil
      expect(@plan).to be_invalid
    end

    it "プラン名は35文字まで有効であること" do
      @plan.plan_name = "a" * 35
      expect(@plan).to be_valid
    end

    it "プラン名は36文字以上は無効であること" do
      @plan.plan_name = "a" * 36
      expect(@plan).to be_invalid
    end
  end

  describe 'plan_content' do
    it "プラン内容が無い場合、無効であること" do
      @plan.plan_content = nil
      expect(@plan).to be_invalid
    end

    it "プラン内容は300文字まで有効であること" do
      @plan.plan_content = "a" * 300
      expect(@plan).to be_valid
    end

    it "プラン内容は301文字以上は無効であること" do
      @plan.plan_content = "a" * 301
      expect(@plan).to be_invalid
    end
  end

  describe 'plan_time' do
    it "プラン時間が無い場合、無効であること" do
      @plan.plan_time = nil
      expect(@plan).to be_invalid
    end
    it "プラン時間が1000分まで有効であること" do
      @plan.plan_time = 1000
      expect(@plan).to be_valid
    end
    it "プラン時間が1000分以上は無効であること" do
      @plan.plan_time = 1001
      expect(@plan).to be_invalid
    end
  end

  describe 'plan_price' do
    it "プラン料金が無い場合、無効であること" do
      @plan.plan_price = nil
      expect(@plan).to be_invalid
    end
    it "プラン料金が300000円まで有効であること" do
      @plan.plan_price = 300000
      expect(@plan).to be_valid
    end
    it "プラン料金が300001円以上は無効であること" do
      @plan.plan_price = 300001
      expect(@plan).to be_invalid
    end
  end

end
