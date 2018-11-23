Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post 'foods/pay', to: 'foods#pay'
  get 'foods/payment_successful', to: 'foods#payment_successful'
  post 'foods/checkout', to: 'foods#checkout'
  get 'foods/checkout_success', to: 'foods#checkout_success'
  get 'foods/search_results/', to: 'foods#search_results'
  get 'foods/add_to_cart/:id', to: 'foods#add_to_cart'
  get 'foods/remove_from_cart/:id', to: 'foods#remove_from_cart'
  get 'foods/show_cart', to: 'foods#show_cart'
  get 'foods/change_quantity/:id/', to: 'foods#change_quantity'
  get 'foods/:id', to: 'foods#show'

  get 'categories/', to: 'categories#index'
  get ':permalink', to: 'pages#permalink'
  get 'categories/:name/:page', to: 'categories#show'
  get 'categories/:name/', to: 'categories#show'

  get 'user/register', to: 'user#register'
  post 'user/register_submit', to: 'user#register_submit'
  get 'user/login', to: 'user#login'
  post 'user/login_submit', to: 'user#login_submit'
  get 'user/logout', to: 'user#logout'

  get 'order/index'
  get 'order/:id', to: 'order#show'

  resources :charges
  
  root to: 'foods#index'
end
