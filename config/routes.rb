Board::Application.routes.draw do
  root to: 'home#index'
  filter :locale
  devise_for :users

  resources :tags

  resources :items do
    resources :messages, :only => [:new, :create]
  end

  namespace :dashboard do
    resources :items do
      resources :photos
      resources :messages
    end
    resources :messages
  end
end
