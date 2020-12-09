class User::TopController < User::Base
  include SmartYoyakuApi::User
  require 'json'
  before_action :set_categories
  before_action :not_found, only: :details
  before_action :correct_user, only: :messages
  before_action :correct_user2, only: [:message_show, :history]
  before_action :set_store, only:[:message_new, :message_create, :message_update]
  before_action :set_message, only:[:message_show, :message_update]

  def index
  end

  def shop
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @all_store = Store.categorized(params[:category_id]).active
    else
      @all_store = Store.active
    end

    # マッサージ師の検索機能
    @search = Store.ransack(params[:q])
    @store_result = @search.result
  end

  def details
    @reserve_app_url = reserve_app_url
    @plans = @store.plans
    @masseurs = @store.masseurs
    # 閲覧中のstoreが持っている出張範囲(各マッサージ師が持っている出張範囲)を全て取得
    @ranges = @masseurs.map { |masseur| masseur.business_trip_ranges.pluck(:city_id).map {|id| City.find_by(id: id) }}
    # 取得した出張範囲で被っている出張範囲を一つにする。 それぞれのIDを取得
    @prefecture_ids = @ranges.flatten.uniq.map {|city| city.prefecture_id}
    @city_ids = @ranges.flatten.uniq.map {|city| city.id}

    # 閲覧中の口コミを取得
    @reviews = Store.find(params[:id]).reviews

    @store_images = @store.store_images.first
    unless @store_images.nil?
      @count_store_image = @store_images.store_image.count
      @count_sm_image = @store_images.sm_image.count
    end
  end

  def messages
    @messages = Message.where(user_id: current_user.id).order(created_at: "DESC")
    @replies = Reply.where(reply_from: "store_manager")
  end

  def message_show
    @replies = Reply.where(message_id: @message.id).order(created_at: "ASC")
    @reply = Reply.new
  end

  def message_new
    @message = Message.new
  end

  def message_create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = "メッセージを送信しました。"
      redirect_to details_url(@store)
    else
      render :message_new
    end
  end

  # メッセージを開くと同時に既読にする
  def message_update
    if Reply.where(reply_from: "store_manager", message_id: @message.id).present?
      update_reply_params.each do |id, item|
        reply = Reply.find(id)
        reply.update_attributes(item)
      end
    end
    redirect_to message_show_url(current_user.id, @message)
  end

  def history
    url = reserve_app_url + "/api/v1/store_member/21/store_member_tasks"
    uri = `curl -X GET "#{url}"`
    @tasks = JSON.parse(uri)["tasks"]
  end

  private

    # ヘッダーとトップページのカテゴリ一覧表示用
    def set_categories
      @categories = Category.all
    end

    # @storeのstore_managerが無料プラン契約中の場合404エラーを表示
    def not_found
      @store = Store.find(params[:id])
      if @store.store_manager.order_plan.nil?
        raise ActiveRecord::RecordNotFound, "こちらのページは現在表示することができません。"
      end
    end

    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:title, :content, :store_id, :user_id, :checked)
    end

    def update_reply_params
      params.permit(replies: [:checked])[:replies]
    end

    # urlに含まれるuser.idがcurrent_userと紐づいていない場合警告
    def correct_user
      @user = User.find(params[:id])
      flash[:danger] = "アクセス権限がありません。"
      redirect_to(root_url) unless @user == current_user
    end

    def correct_user2
      @user = User.find(params[:user_id])
      flash[:danger] = "アクセス権限がありません。"
      redirect_to(root_url) unless @user == current_user
    end
end
