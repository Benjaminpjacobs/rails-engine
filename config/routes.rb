Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/invoices/find', to: "invoices#show"
      get '/invoices/find_all', to: "invoices#index"
      
      resources :invoices, only: [:index, :show]

      get '/items/find', to: "items#show"
      get '/items/find_all', to: "items#index"
      resources :items, only: [:index, :show]
    end
  end
end
