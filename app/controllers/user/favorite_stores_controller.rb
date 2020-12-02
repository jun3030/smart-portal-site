class User::FavoriteStoresController < User::Base

  before_action :set_categories

  def index
    @favorite_stores = current_user.favorite_stores
  end

  def create
    store=Store.find(params[:store_id])
    if FavoriteStore.create(user_id: current_user.id,store_id:store.id)
      flash[:success] = "お気に入り店舗に登録しました。"
      redirect_to details_url(store)
    else
      flash[:success] = "お気に入り店舗の登録に失敗しました。お手数ですがもう一度やり直して下さい。"
      redirect_to details_url(store)
    end
  end

  def destroy
    debugger
    store=Store.find(params[:store_id])
    if favorite=FavoriteStore.find_by(user_id: current_user.id,store_id:store.id)
      favorite.delete
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  private

  # ヘッダーとトップページのカテゴリ一覧表示用
  def set_categories
    @categories = Category.all
  end
end
