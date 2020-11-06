class User::ReviewController < User::Base
  before_action :set_categories
  before_action :set_store, only: [:index, :new, :create, :edit, :update, :show, :destroy]

  def index
    @reviews = Store.find(params[:store_id]).reviews.page(params[:page]).per(20)
  end

  def new
    @review = @store.reviews.build
    @reviews = Review.all
  end

  def create
    @review = @store.reviews.build(review_params)
    if @review.save
      flash[:success] = "口コミを投稿しました。"
      redirect_to user_store_review_index_path(@store.id)
    else
      flash[:danger] = "口コミが投稿できませんでした。"
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @masseurs = @store.masseurs
    # 閲覧中のstoreが持っている出張範囲(各マッサージ師が持っている出張範囲)を全て取得
    @ranges = @masseurs.map { |masseur| masseur.business_trip_ranges.pluck(:city_id).map {|id| City.find_by(id: id) }}
    # 取得した出張範囲で被っている出張範囲を一つにする。 それぞれのIDを取得
    @prefecture_ids = @ranges.flatten.uniq.map {|city| city.prefecture_id}
    @city_ids = @ranges.flatten.uniq.map {|city| city.id}
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    if @review = @store.reviews.find(params[:id]).update(review_params)
      flash[:success] = "口コミを更新しました。"
      redirect_to user_store_review_show_path
    else
      flash.now[:danger] = "口コミが更新されませんでした。更新するには全ての項目を記入して下さい。"
      render :edit
    end
  end

  def destroy
    if @store.reviews.find(params[:id]).destroy
      flash[:success] = '口コミを削除しました。'
      redirect_to details_path(@store.id)
    else
      flash[:danger] = '削除に失敗しました。再度やり直してください。'
      render :edit
    end
  end

  private

  # ヘッダーとトップページのカテゴリ一覧表示用
  def set_categories
    @categories = Category.all
  end

  def set_store
    @store = Store.find(params[:store_id])
  end

  def review_params
    params.require(:review).permit(:store_id, :user_id, :title, :content, :rate)
  end
end
