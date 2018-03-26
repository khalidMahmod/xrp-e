Rails.application.eager_load! if Rails.env.development?

class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Peatio::Application.routes.draw do

  root 'welcome#index'
  get 'logout' => 'top#logout'
  resource :member_mfa_session
  get	'/member_mfa_session/check_verify' =>	'member_mfa_sessions#check_varify'
  match '/member_mfa_session/verify' => 'member_mfa_sessions#verify', via: [:get, :post]
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure', :as => :failure
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]

  get '/documents/api_v2'
  get '/documents/websocket_api'

  resources :login_histories
  scope module: :private do
    namespace :deposits do
      resources :dollars do
        collection do
          post :deposit
          get :usd_deposit
        end
      end
    end
    namespace :withdraws do
      resources :dollars do
        collection do
          post :withdraws
          get :usd_withdraws
        end
      end
    end
    resource  :id_document, only: [:edit, :update]
    resources :settings, only: [:index]
    resources :api_tokens do
      member do
        delete :unbind
      end

    end

    resources :fund_sources, only: [:create, :update, :destroy]

    resources :funds, only: [:index] do
      collection do
        post :gen_address
      end
    end

    namespace :deposits do
      Deposit.descendants.each do |d|
        resources d.resource_name do
          collection do
            post :gen_address
          end
        end
      end
    end

    namespace :withdraws do
      Withdraw.descendants.each do |w|
        resources w.resource_name
      end
    end

    resources :account_versions, :only => :index

    resources :exchange_assets, :controller => 'assets' do
      member do
        get :partial_tree
      end
    end
    get '/fees' => 'fees#index', as: :fees_index
    get '/history/orders' => 'history#orders', as: :order_history
    get '/history/trades' => 'history#trades', as: :trade_history
    get '/history/account' => 'history#account', as: :account_history

    resources :markets, :only => :show, :constraints => MarketConstraint do
      resources :orders, :only => [:index, :destroy] do
        collection do
          post :clear
        end
      end
      resources :order_bids, :only => [:create] do
        collection do
          post :clear
        end
      end
      resources :order_asks, :only => [:create] do
        collection do
          post :clear
        end
      end
    end

   post '/pusher/auth', to: 'pusher#auth'
  end

  scope ['', 'webhooks', ENV['WEBHOOKS_SECURE_URL_COMPONENT'].presence, ':ccy'].compact.join('/'), as: 'webhooks' do
    post 'tx_created', to: 'webhooks#tx_created'
  end

  draw :admin

  mount APIv2::Mount => APIv2::Mount::PREFIX

  namespace :test do
    resources :members, only: :index
  end unless Rails.env.production?
end
