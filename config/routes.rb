Rails.application.routes.draw do
  devise_for :users
  get 'users/profile', to: 'users#profile'
  get 'users/account', to: 'users#account'
  get 'users/profile/edit', to: 'users#edit_profile'
  patch 'users/profile', to: 'users#update_profile'
  root 'rooms#index'

  resources :rooms do
    collection do
      get 'own' # ユーザーごとの部屋の一覧表示
    end
    resources :reservations, only: [:new, :create, :show, :destroy] do
      collection do
        get 'confirm'
      end
    end
  end

  # ユーザーが予約した部屋の一覧ページ用のルーティング
  get 'user_reservations', to: 'reservations#user_reservations'
end
