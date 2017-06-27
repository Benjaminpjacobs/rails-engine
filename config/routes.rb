Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants#show'
      get 'merchants/find_all', to: 'merchants#index'

      resources :merchants, only: [:index, :show]

      get 'transactions/find', to: 'transactions#show'
      get 'transactions/find_all', to: 'transactions#index'
      
      resources :transactions, only: [:index, :show]

      get '/invoices/find', to: "invoices#show"
      get '/invoices/find_all', to: "invoices#index"
      
      resources :invoices, only: [:index, :show]

      get '/items/find', to: "items#show"
      get '/items/find_all', to: "items#index"

      resources :items, only: [:index, :show]

      get '/customers/find', to: 'customers#show'
      get '/customers/find_all', to: 'customers#index'

      resources :customers, only: [:index, :show]
    end
  end
end
