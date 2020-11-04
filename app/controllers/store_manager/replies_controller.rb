class StoreManager::RepliesController < ApplicationController

  before_action :set_store, only:[:new, :create]
  before_action :set_message, only:[:new, :create]

  def new
    @reply = Reply.new
    @replies = Reply.where(message_id: @message.id).order(created_at: "ASC")
  end

  def create
    @reply = Reply.new(reply_params)
    if reply_params[:reply_form] == "store_manager" #store_managerが返信した場合
      if @reply.save
        flash[:success] = "メッセージを返信しました。"
        redirect_to new_store_manager_store_message_reply_url(@reply.store_id, @reply.message_id)
      else
        render :new
      end
    else #userが返信した場合
      if @reply.save
        flash[:success] = "メッセージを返信しました。"
        redirect_to store_message_show_path(@reply.store_id, @reply.message_id)
      else
        render 'user/top/message_show'
      end
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_to new_store_manager_store_message_reply_url(@reply.store_id, @reply.message_id)
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_message
      @message = Message.find(params[:message_id])
    end

    def reply_params
      params.require(:reply).permit(:reply, :store_id, :user_id, :message_id, :checked, :reply_from)
    end
end
