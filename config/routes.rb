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
  # scope module: :admin do
    #resource :admin, only: [:create] do
      #post 'ban/:user_id' => 'admins#ban_user', as: :ban_user
      #post 'allow/:user_id' => 'admins#allow_user', as: :allow_user
    #end
    resources :photos, only: [] do
      resources :bans, only: [:new, :create, :destroy]
    end

    resources :users, only: [] do
      resources :ban, only: [:new, :create, :destroy]
    end
    #resources :users do
      #resources :ban, only: [:new, :create]
      #resources :allow, only: [:create]
    #end
  end

  resources :items, only: [:index]
end
