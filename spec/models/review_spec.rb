require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = build(:review)
  end

  it "有効なレビューをもつこと" do
    expect(@review).to be_valid
  end
  it "user_id,store_idがなければ無効であること" do
    @review.store_id = nil

    expect(@review).to be_invalid
  end

  describe 'content' do
    it "レビューは未入力の場合無効であること" do
      @review.content = nil
      expect(@review).to be_invalid
    end
    it "レビューは1文字以上であること" do
      @review.content = "a" * 1
      expect(@review).to be_valid
    end
    it "レビューは300文字以下であること" do
      @review.content = "a" * 300
      expect(@review).to be_valid
    end
    it "レビューは301文字以上は無効であること" do
      @review.content = "a" * 301
      expect(@review).to be_invalid
    end
  end
end
