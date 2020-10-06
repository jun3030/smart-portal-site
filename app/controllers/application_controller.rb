class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_store_parameters, if: :devise_controller?

  protected

  # deviceを使用したuserのsign_upとupdateに使用
  # users/registrations_controllerに移すとログアウトできなくなる
  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation, :nickname, :address, :gender ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  #deviceを使用したStoreManagerのsign_upに使用
  def configure_permitted_store_parameters
    added_store_attrs = [:name, :email, :password, :password_confirmation,
                         store_attributes:[:id, :store_name, :adress, :store_phonenumber, :store_description,
                         store_images_attributes:[:id , { store_image: [] }],
                         plans_attributes:[:plan_name, :plan_content, :plan_time, :plan_price, plan_images_attributes:[:id , { plan_image: [] }]]]
                        ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_store_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_store_attrs
  end

  def after_sign_in_path_for(resource)
    # store_managerがログイン中にstore_manager新規作成ページに行こうとするとrootに遷移
    if store_manager_signed_in?
      root_path
    else
    # 一般ユーザーがログイン中に新規作成ページに行こうとするとマイページに遷移
      user_path(current_user)
    end
  end
end
