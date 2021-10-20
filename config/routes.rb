Rails.application.routes.draw do
    # get "/" => "home#index"
   
  
    #Rest api resources
    namespace :api do
      namespace :v1 do
        resources :users
        resources :menu_items
        resources :menu_categories
        resources :cart_items
        resources :orders do 
          collection do 
            post "update_order_status",to: "orders"
          end
        end
        resources :order_items
        # post "/archive_orders",to: "orders#archive_orders", as: :archive_orders
      end
    end
end

