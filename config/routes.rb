Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'

  resources :rooms do
    collection do
      get 'own' # ユーザーごとの部屋の一覧表示
    end
    resources :reservations, only: [:new, :create, :show, :destroy]
  end
end
