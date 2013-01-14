Board::Application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :tags
  resources :items do
    resources :photos
    resources :messages
  end
  namespace :dashboard do
    resources :items
  end
end
