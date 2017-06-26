Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :invoices, only: [:index, :show]
      get '/invoices/find', to: "invoices#show"
    end
  end
end
