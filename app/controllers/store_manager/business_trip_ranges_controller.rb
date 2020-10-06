class StoreManager::BusinessTripRangesController < StoreManager::Base
  
  include StoreManager::BusinessTripRangesHelper
  
  before_action :set_masseur, only: [:edit, :update, :show]
  before_action :corrrect_store_manager, only: [:edit, :update, :show]
  
  def index
    @store = current_store_manager.store
    @masseurs = @store.masseurs
  end
  
  
  
  def edit
    @prefectures = Prefecture.all
    @ranges = @current_masseur.business_trip_ranges
  end
  
  def update
    # チェックがあった場合
    if params[:masseur].present?
      @current_masseur.update(city_business_trip_range_params)
      flash[:success] = "出張範囲を更新しました。"
      redirect_to store_manager_masseurs_business_trip_ranges_url
    # 一つもチェックがなかった場合
    else
      flash[:danger] = "出張範囲を選択してください。"
      render :edit
    end
  end
  
  def show
    @business_trip_ranges = @current_masseur.business_trip_ranges
    # 閲覧中のマッサージ師が持っている出張範囲(市町村)が属している都道府県IDを配列にして取得
    @prefecture_ids = @current_masseur.business_trip_ranges.pluck(:city_id).map {|id| City.find_by(id: id).prefecture_id } 
    # 閲覧中のマッサージ師が持っているcity_idを配列で取得
    @city_ids = @current_masseur.business_trip_ranges.pluck(:city_id)
  end
  
  def city_select
    init(params[:prefecture_id].to_i)
  end
  
  private
  
  def set_masseur
    @current_masseur = Masseur.find(params[:masseur_id])
  end
  
  def city_business_trip_range_params
    if params[:masseur].present?
      params.require(:masseur).permit(city_ids: [])
    end
  end
  
  def corrrect_store_manager
    unless current_store_manager.store.masseurs.ids.include?params[:masseur_id].to_i
      flash[:danger] = "アクセス権限がありません。"
      redirect_to store_manager_url(current_store_manager)
    end
  end

end
