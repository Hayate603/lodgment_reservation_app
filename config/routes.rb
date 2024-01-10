Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'

  resources :rooms do
    resources :reservations, only: [:new, :create, :show, :destroy]
  end
end
