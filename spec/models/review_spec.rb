require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "Review" do
    before do
      @review = build(:review)
    end
    it "有効なreviewである事" do
      expect(@review).to be_valid
    end
    context "titleが存在しなかった場合" do
      it "無効なレビューである事" do
        @review.title = nil
        expect(@review).to be_invalid
      end
    end
    context "titleが30文字より多かった場合" do
      it "無効なレビューである事" do
        @review.title = "a" * 31
        expect(@review).to be_invalid
      end
    end
    context "titleが30文字以内だった場合" do
      it "有効なレビューである事" do
        @review.title = "a" * 30
        expect(@review).to be_valid
      end
    end
    context "contentが存在しなかった場合" do
      it "無効なレビューである事" do
        @review.content = nil
        expect(@review).to be_invalid
      end
    end
    context "contentが300文字より多かった場合" do
      it "無効なレビューである事" do
        @review.content = "a" * 301
        expect(@review).to be_invalid
      end
    end
    context "contentが300文字以内だった場合" do
      it "有効なレビューである事" do
        @review.content = "a" * 300
        expect(@review).to be_valid
      end
    end
    context "rateが存在しなかった場合" do
      it "無効なレビューである事" do
        @review.rate = nil
        expect(@review).to be_invalid
      end
    end
    context "rateが5より大きかった場合" do
      it "無効なレビューである事" do
        @review.rate = 6
        expect(@review).to be_invalid
      end
    end
    context "rateが5以内だった場合" do
      it "有効なレビューである事" do
        @review.rate = 5
        expect(@review).to be_valid
      end
    end
    context "rateが1より大きかった場合" do
      it "有効なレビューである事" do
        @review.content = 2
        expect(@review).to be_valid
      end
    end
    context "user_idがnilの場合" do
      it "無効である事" do
        @review.user_id = nil
        expect(@review).to be_invalid
      end
    end
    context "store_idがnilの場合" do
      it "無効である事" do
        @review.store_id = nil
        expect(@review).to be_invalid
      end
    end
  end
end
