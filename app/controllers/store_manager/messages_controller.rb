class StoreManager::MessagesController < ApplicationController

  before_action :set_store, only:[:new, :create, :index]
  before_action :set_message, only:[:show, :destroy]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = "メッセージを送信しました。"
      redirect_to details_url(@store)
    else
      flash[:danger] = "メッセージの送信に失敗しました。"
      render template: "top/message_new"
    end
  end

  def index
    @messages = Message.where(store_id: @store.id).order(created_at: "ASC")
  end

  def show
  end

  def destroy
    @message.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_to messages_url
  end

  def reply
  end

  def create_reply
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:title, :content, :message_status, :store_id, :user_id)
    end
end
