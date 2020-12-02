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
    store=Store.find(params[:store_id])
    favorite=FavoriteStore.find_by(user_id: current_user.id,store_id:store.id)
    favorite.destroy
    flash[:success] = "#{store.store_name}をお気に入りの店舗から削除しました。"
    redirect_to user_favorite_stores_index_url(current_user)
  end

  private

  # ヘッダーとトップページのカテゴリ一覧表示用
  def set_categories
    @categories = Category.all
  end
end
