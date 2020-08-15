# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  require 'net/http'
  require 'uri'
  require 'json'

  def line; basic_action end

  private

  def basic_action
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      if @profile
        @profile.set_values(@omniauth)
        sign_in(:user, @profile.user)
      else
        @profile = SocialProfile.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
        email = @omniauth['info']['email'] ? @omniauth['info']['email'] : "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
        @profile.user = current_user || User.create!(email: email, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
        @profile.set_values(@omniauth)
        sign_in(:user, @profile.user)
        # redirect_to edit_user_path(@profile.user.id) and return
      end
    end
    flash[:success] = "ログインしました。"
    redirect_to root_path
  end
  
  # lineのアクセストークン取得コード
  # def set_access_token
  #   uri = `curl -X POST https://api.line.me/oauth2/v2.1/token \
  #   -H 'Content-Type: application/x-www-form-urlencoded' \
  #   -d 'grant_type=authorization_code' \
  #   -d 'code="#{params[:code]}"' \
  #   -d 'redirect_uri=https://0f1424db0c1a.ngrok.io/users/auth/line/callback' \
  #   -d 'client_id=1654658492' \
  #   -d 'client_secret=4ed72a5dbea0f9b457d91868be60cec3'`
  #   @api = JSON.parse(uri)
  # end

  # def google
  #   @user = User.find_for_google(request.env['omniauth.auth'])

  #   if @user.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
  #     sign_in_and_redirect @user, event: :authentication
  #     session[:user_id] = @user.id
  #   else
  #     session['devise.google_data'] = request.env['omniauth.auth']
  #     redirect_to new_user_registration_url
  #   end
  # end
  
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
