Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:show] # ユーザーマイページへのルーティング


  root 'tweets#index'

  get 'tweets/search' => 'tweets#search'

  resources :tweets do
    # 地域別ページ用のルート
    collection do
      get 'region/:region', to: 'tweets#region', as: 'region'
    end

    resources :likes, only: [:create, :destroy]
  end
end