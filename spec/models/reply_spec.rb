require 'rails_helper'

RSpec.describe Reply, type: :model do
  before do
    @reply = build(:reply)
  end

  describe 'reply' do
    it "replyがなかった場合は無効であること" do
      @reply.reply = nil
      expect(@reply).to be_invalid
    end
  end
end
