Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]

      get 'merchants/find', to: 'merchants#show'
      get 'merchants/find_all', to: 'merchants#index'

      resources :transactions, only: [:index, :show]

      resources :invoices, only: [:index, :show]

      get '/invoices/find', to: "invoices#show"
      get '/invoices/find_all', to: "invoices#index"
      
      resources :items, only: [:index, :show]

      get '/items/find', to: "items#show"
      get '/items/find_all', to: "items#index"
    end
  end
end
