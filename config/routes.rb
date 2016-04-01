Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end

  root :to => 'home#index'

  resources :users_admin, :controller => "users"
end
