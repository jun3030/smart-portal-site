# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # layout 'user' <- 有効にするとheaderとfotterが3回表示されレイアウトが崩れる

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # before_action :authenticate_user!, only: [:show] <- 動作しなかったのでs代わりにigned_in_userを作成
  before_action :signed_in_user, only: [:show]
  before_action :correct_user, only: [:show]

  def show
    @replies = Reply.where(checked: "未読", user_id: current_user.id)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  # userのログイン後の画面を指定
  # users/registrations_controllerに移すと動作しなくなる

  # user情報の更新後の画面を指定
  def after_update_path_for(users)
    user_path(current_user)
  end

  # ログイン中ユーザーの有無を確認
  def signed_in_user
    unless user_signed_in?
      flash[:alert] = "ログインしてください。"
      redirect_to new_user_session_url
    end
  end

  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    unless (params[:id]) == current_user.id.to_s
      flash[:notice] = "アクセス権限がありません。"
      redirect_to root_url
    end
  end
end
