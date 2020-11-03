class User::ReviewController < User::Base
  before_action :set_categories
  before_action :set_store, only: [:new, :create, :edit]

  def index
    @reviews = Store.find(params[:store_id]).reviews
  end

  def new
    @store = Store.find(params[:store_id])
    @review = @store.reviews.build
    @reviews = Review.all
  end

  def create
    @store = Store.find(params[:store_id])
    @review = @store.reviews.build(review_params)
    if @review.save
      flash.now[:success] = "口コミを投稿しました"
      redirect_to user_store_review_index_path(@store.id)
    else
      flash[:danger] = "口コミが投稿できませんでした"
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @store = Store.find(params[:store_id])
    if @review = @store.reviews.update(review_params)
      debugger
      flash[:success] = "口コミを更新しました。"
      redirect_to user_store_review_show_path
    else
      flash[:danger] = "口コミが更新されませんでした。"
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
