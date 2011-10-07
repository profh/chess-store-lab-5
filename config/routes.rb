Dvra::Application.routes.draw do  
  scope ':session_secret' do
    # account functions
    resources :users
    get 'users/:id/change_password' => 'users#change_password', :as => 'change_password'

    # products functions
    get 'categories/:category_id(/order/:order(/page/:page))' => 'products#index', :as => 'products'
    get 'products/search(/order/:order(/page/:page))' => 'products#search', :as => 'product_search'
    get 'products/:id' => 'products#show', :as => 'product'
    get 'products/delete/:id' => 'products#destroy', :as => 'detroy_product'
    post 'products/:product_id/reviews' => 'reviews#create', :as => 'product_reviews'

    # cart functions
    get 'cart' => 'cart#show', :as => 'cart'
    post 'cart/add' => 'cart#add', :as => 'add_to_cart'
    post 'cart/remove' => 'cart#remove', :as => 'remove_from_cart'
    put 'cart/update/:product_id' => 'cart#update', :as => 'update_cart_item'
  
    # mailing list functions
    post 'mailing-list' => 'mailing_list#join', :as => 'join_mailing_list'
  
    # login/logout functions
    get 'login' => 'sessions#new', :as => 'login'
    post 'login' => 'sessions#create', :as => 'login'
    delete 'logout' => 'sessions#destroy', :as => 'logout'
  
    # database stuff
    post 'change_level' => 'sessions#change_level', :as => 'change_level'
    delete 'reset' => 'sessions#reset_database', :as => 'reset_database'
  
    # static paths
    match 'statics' => 'statics#show', :as => 'statics'
  
    root :to => 'store#index', :as => 'store'
  end
  
  root :to => 'store#index', :as => 'store'
end