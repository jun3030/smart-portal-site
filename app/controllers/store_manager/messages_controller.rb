class StoreManager::MessagesController < ApplicationController

  before_action :set_categories, only:[:new, :create, :index, :update]
  before_action :set_store, only:[:new, :create, :index, :update]
  before_action :set_message, only:[:destroy, :update]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = "メッセージを送信しました。"
      redirect_to details_url(@store)
    else
      render :new
    end
  end

  def index
    @messages = Message.where(store_id: @store.id).order(created_at: "ASC")
  end

  def update
    @message.update_attributes(update_message_params)

    redirect_to new_store_manager_store_message_reply_path(@store, @message)
  end

  def destroy
    @message.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_to messages_url
  end

  private
    def set_categories
      @categories = Category.all
    end

    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:title, :content, :message_status, :store_id, :user_id, :checked)
    end

    def update_message_params
      params.permit(:checked)
    end
end
