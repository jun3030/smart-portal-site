class User::TopController < User::Base
  include SmartYoyakuApi::User
  before_action :set_categories
  before_action :not_found, only: :details

  def index
  end

  def shop
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @all_store = Store.categorized(params[:category_id]).active
    else
      @all_store = Store.active
    end
  end

  def details
    @reserve_app_url = reserve_app_url
    @plans = @store.plans
    @masseurs = @store.masseurs
    # 閲覧中のstoreが持っている出張範囲(各マッサージ師が持っている出張範囲)を全て取得
    ranges = @masseurs.map { |masseur| masseur.business_trip_ranges.pluck(:city_id).map {|id| City.find_by(id: id) }}
    # 取得した出張範囲で被っている出張範囲を一つにする。 それぞれのIDを取得
    @prefecture_ids = ranges.flatten.uniq.map {|city| city.prefecture_id}
    @city_ids = ranges.flatten.uniq.map {|city| city.id}

    @store_images = @store.store_images.first
    unless @store_images.nil?
      @count_store_image = @store_images.store_image.count
    end
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
end
