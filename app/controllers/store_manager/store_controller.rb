class StoreManager::StoreController < StoreManager::Base
  include SmartYoyakuApi::Calendar
  
  before_action :sign_in_store_manager, only: [:edit]
  before_action :correct_store, only: [:edit]

  def new
  end

  def create
  end

  def edit
    @store = current_store_manager.store
  end

  def update
    @store = current_store_manager.store
    ActiveRecord::Base.transaction do
      if @store.update(store_params)
        flash[:success] = "#{@store.store_name}の情報を更新しました。"
        redirect_to store_manager_url(current_store_manager)
        # 予約システム側のCalendar情報を更新
        @response = update_calendar(@store)
        unless JSON.parse(@response)["status"] == "200"
          raise StandardError, "予約システムでcalendarのupdateに失敗しました。"
        end
      else
        flash.now[:danger] = "入力内容に誤りがあったため更新できませんでした。"
        render :edit
      end
    end
  end

  private
    
    # ログインしているかどうかの判定
    def sign_in_store_manager
      unless store_manager_signed_in?
        flash[:danger] = "アカウント登録もしくはログインしてください。"
        redirect_to store_manager_session_url
      end
    end
    # urlに含まれるstore.idがcurrent_store_managerと紐づいていない場合警告
    def correct_store
      unless params[:id] == current_store_manager.store.id.to_s
        flash[:danger] = "アクセス権限がありません。"
        redirect_to store_manager_url(current_store_manager)
      end
    end

    def store_params
      params.require(:store).permit(:store_name, :adress, :store_phonenumber, :store_description, store_images_attributes:[:id, {store_image: []},:remove_store_image ])
    end
end
