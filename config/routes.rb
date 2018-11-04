Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :foods, only: [:index, :show]
  get 'categories/', to: 'categories#index'
  get ':permalink', to: 'pages#permalink'
  get 'categories/:name/:page', to: 'categories#show'
  get 'categories/:name/', to: 'categories#show'
  
  root to: 'foods#index'
end
