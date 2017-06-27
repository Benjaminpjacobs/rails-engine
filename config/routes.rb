Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/invoices/find_all', to: "invoices#index"
      get '/invoices/find', to: "invoices#show"
      resources :invoices, only: [:index, :show]
    end
  end
end
