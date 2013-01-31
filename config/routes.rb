Board::Application.routes.draw do
  root to: 'home#index'
  filter :locale
  devise_for :users

  resources :tags, only: [:index, :show]

  resources :items do
    resources :messages
  end

  namespace :dashboard do
    resources :items do
      resources :photos
    end
  end

  resources :users

  scope module: :admin do
    resource :admin, only: [:create]
  end
end
