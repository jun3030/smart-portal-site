Rails.application.routes.draw do

  # User↓========================================================================================
    root            to: "user/top#index"
    get "/shop",    to: "user/top#shop"
    get "/store/:id", to: "user/top#details", as: :details
    get "user/:id/messages", to: "user/top#messages", as: :messages
    resources :store, only: :index do
      get "/messages/new", to: "user/top#message_new", as: :message_new
      post "messages", to: "user/top#message_create", as: :message_create
      get "messages/:id", to: "user/top#message_show", as: :message_show
      patch "messages/update/:id", to: "user/top#message_update", as: :message_update
    end
  # devise↓ =====================================================================================
    devise_for :admins, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :masseurs
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_scope :user do
      get "/user/:id", :to => "users/registrations#show", as: :user

      get "/user/store/:store_id/review", to: "user/review#index", as: :user_store_review_index
      post "/user/store/:store_id/review", to: "user/review#create"
      get "/user/store/:store_id/review/new", to: "user/review#new", as: :user_store_review_new
      get "/user/store/:store_id/review/:id/edit", to: "user/review#edit", as: :user_store_review_edit
      get "/user/store/:store_id/review/:id", to: "user/review#show", as: :user_store_review_show
      patch "/user/store/:store_id/review/:id", to: "user/review#update", as: :user_store_review_update
      delete "/user/store/:store_id/review/:id", to: "user/review#destroy"
    end

    devise_for :users, controllers: {
      sessions:      'users/sessions',
      passwords:     'users/passwords',
      registrations: 'users/registrations',
      omniauth_callbacks: "users/omniauth_callbacks"
    }
    devise_for :store_managers, :controllers => {
      :registrations => 'store_managers/registrations',
      :sessions => 'store_managers/sessions'
    }
    devise_scope :store_manager do
      get "store_managers/:id", :to => "store_managers/registrations#show", as: "store_managers_show"
      get "store_managers/:id/reservations", :to => "store_managers/registrations#index", as: "store_managers_index"
      get "store_manager/:id/detales", :to => "store_managers/registrations#detales", as: "store_managers_detales"
      get "store_managers/sign_out", :to => "store_managers/sessions#destroy"
    end

    # devise_scope :store_managers do
    #   get "sign_in", :to => "store_managers/sessions#new"
    #   get "sign_out", :to => "store_managers/sessions#destroy"
    # end




  # Admin↓========================================================================================
    namespace :admin do
    #  get '/top', to: 'admins#top'
    end

  # Masseur↓========================================================================================
    namespace :masseur do

    end

  # Store_manager↓========================================================================================
    namespace :store_manager do
      get "/:id/top", to: 'top_page#top'
      patch "update_calendar_status", to: 'top_page#update_calendar_status'
      resources :store do
        resources :messages, only: [:index, :destroy, :update] do
          resources :replies, only: [:new, :create, :destroy]
        end
      end
      resources :plans
      resources :masseurs, except: :show
      # 出張範囲のrouting↓========================================================================================
      get "/masseurs/business_trip_ranges", :to => "/store_manager/business_trip_ranges#index"
      get "/masseurs/:masseur_id/business_trip_ranges/edit", :to => "/store_manager/business_trip_ranges#edit", as: "business_trip_ranges_edit"
      get "/masseurs/:masseur_id/business_trip_ranges/show", :to => "/store_manager/business_trip_ranges#show", as: "business_trip_ranges_show"
      patch "/masseurs/:masseur_id/business_trip_ranges/update", :to => "/store_manager/business_trip_ranges#update", as: "business_trip_ranges_update"
      get "/masseurs/:masseur_id/business_trip_ranges/cities_select", :to => "/store_manager/business_trip_ranges#cities_select", as: "cities_select_business_trip_ranges"
    end

    # SmartYoyaku webhook↓==========================================================================
    namespace :smart_yoyaku do
      post "webhook", to: 'webhook#update_order_plan'
    end

end
