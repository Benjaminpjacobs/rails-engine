Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/customers_with_pending_invoices', to: "customers_with_pending_invoices#index"
        get '/:id/favorite_customer', to: "favorite_customer#show"
      end
      
      namespace :customers do
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end

      namespace :transactions do
        get '/:id/invoice', to: 'invoices#show'
      end

      namespace :invoices do
        get '/:id/items', to: 'items#index'
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/customer', to: 'customers#index'
      end
      
      get '/customers/find', to: 'customers#show'
      get '/customers/find_all', to: 'customers#index'

      resources :customers, only: [:index, :show]

      get '/merchants/find', to: 'merchants#show'
      get '/merchants/find_all', to: 'merchants#index'

      resources :merchants, only: [:index, :show]

      get '/items/find', to: "items#show"
      get '/items/find_all', to: "items#index"

      resources :items, only: [:index, :show]

      get '/invoices/find', to: "invoices#show"
      get '/invoices/find_all', to: "invoices#index"
      
      resources :invoices, only: [:index, :show]

      get '/invoice_items/find', to: "invoice_items#show"
      get '/invoice_items/find_all', to: "invoice_items#index"

      resources :invoice_items, only: [:index, :show]

      get '/transactions/find', to: 'transactions#show'
      get '/transactions/find_all', to: 'transactions#index'
      
      resources :transactions, only: [:index, :show]

    end
  end
end
