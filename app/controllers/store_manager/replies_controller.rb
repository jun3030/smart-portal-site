class StoreManager::RepliesController < ApplicationController

  before_action :set_store, only:[:new, :create]
  before_action :set_message, only:[:new, :create]

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.new(reply_params)
    if @reply.save
      flash[:success] = "メッセージを送信しました。"
      redirect_to store_manager_store_messages_path(@store)
    else
      render :new
    end
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_message
      @message = Message.find(params[:message_id])
    end

    def reply_params
      params.require(:reply).permit(:reply, :store_id, :user_id, :message_id)
    end
end
