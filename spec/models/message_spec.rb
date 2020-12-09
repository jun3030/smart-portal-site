require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = build(:message)
  end
  it "有効なメッセージである事" do
    expect(@message).to be_valid
  end
  describe "messageカラムのテスト" do
    context "titleがnilの場合" do
      it "無効なメッセージになる事" do
        @message.title = nil
        expect(@message).to be_invalid
      end
    end
    context "titleがnilの場合" do
      it "無効なメッセージになる事" do
        @message.title = nil
        expect(@message).to be_invalid
      end
    end
    context "contentがnilの場合" do
      it "無効なメッセージになる事" do
        @message.content = nil
        expect(@message).to be_invalid
      end
    end
    context "contentが10文字より下の場合" do
      it "無効なメッセージになる事" do
        @message.content = "a" * 9
        expect(@message).to be_invalid
      end
    end
  end
end
