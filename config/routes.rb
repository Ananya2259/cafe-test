Rails.application.routes.draw do
    # get "/" => "home#index"
   
  
    #Rest api resources
    namespace :api do
      namespace :v1 do
        resources :users
        resources :menu_items
        resources :menu_categories
        resources :cart_items
        resources :orders
        resources :order_items
      end
    end
end

