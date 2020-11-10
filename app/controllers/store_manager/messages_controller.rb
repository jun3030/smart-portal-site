class StoreManager::MessagesController < ApplicationController

  before_action :set_store, only:[:index, :update]
  before_action :set_message, only:[:destroy, :update]

  def index
    @messages = Message.where(store_id: @store.id).order(created_at: "DESC")
    @replies = Reply.where(store_id: @store.id, reply_from: "user")
  end

  # メッセージを開くと同時に既読にする
  def update
    @message.update_attributes(update_message_params)
    if Reply.where(reply_from: "user").present?
      update_reply_params.each do |id, item|
        reply = Reply.find(id)
        reply.update_attributes(item)
      end
    end
    redirect_to new_store_manager_store_message_reply_path(@store, @message)
  end

  def destroy
    @message.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_to messages_url
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:title, :content, :store_id, :user_id, :checked)
    end

    def update_message_params
      params.permit(:checked)
    end

    def update_reply_params
      params.permit(replies: [:checked])[:replies]
    end
end
