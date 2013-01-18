Board::Application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :tags
  resources :items do
    resources :messages
  end
  namespace :dashboard do
    resources :items do
      resources :photos
    end
  end
end
