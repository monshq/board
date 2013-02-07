Board::Application.routes.draw do
  root to: 'home#index'
  filter :locale
  devise_for :users, controllers: {sessions: "sessions"}

  resources :tags, only: [:index, :show]

  resources :items, only: [:index, :show] do
    resources :messages, :only => [:new, :create]
  end

  namespace :dashboard do
    resources :items do
      resources :photos
      resources :messages
    end
    resources :messages
  end

  resources :users

  namespace :admin do
    resources :photos, only: [] do
      resources :ban, only: [:new, :create, :destroy], controller: 'ban_photo'
    end

    resources :users, only: [] do
      resources :ban, only: [:new, :create, :destroy], controller: 'ban_user'
    end
  end

  resources :items, only: [:index]
end
