namespace :admin do
  get '/', to: 'dashboard#index', as: :dashboard
  get '/daemon_start', to:'dashboard#daemon_start'
  get '/daemon_stop', to:'dashboard#daemon_stop'
  get '/individual_daemon_stop', to:'dashboard#individual_daemon_stop'
  get '/individual_daemon_start', to:'dashboard#individual_daemon_start'

  resources :id_documents,     only: [:index, :show, :update]
  resource  :currency_deposit, only: [:new, :create]
  resources :proofs
  resources :currency_amounts

  resources :members, only: [:index, :show] do
    member do
      post :faenable
      post :active
      post :toggle
    end
  end

  namespace :deposits do
    Deposit.descendants.each do |d|
      resources d.resource_name
    end
  end

  namespace :withdraws do
    Withdraw.descendants.each do |w|
      resources w.resource_name
    end
  end

  namespace :statistic do
    resource :members, :only => :show
    resource :orders, :only => :show
    resource :trades, :only => :show
    resource :deposits, :only => :show
    resource :withdraws, :only => :show
  end
end
