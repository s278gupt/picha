Rails.application.routes.draw do
  devise_for :users

  get 'home/index'
  get 'tags/:tag', to: 'pictures#index', as: "tag"

  root to: 'home#index'

  resources :albums
  resources :pictures
end
