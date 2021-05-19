Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :users, only: [:new, :create, :index, :show, :destroy, :edit ] do
    resources :pets, only: [:new, :create, :index, :show, :destroy, :edit ]
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :post_blogs, only: [:new, :create, :index, :show, :destroy, :edit, :update ] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  # タグによって絞り込んだ投稿を表示するアクションへのルーティング
  resources :tags, only: [:search] do
    get 'post_blogs', to: 'posts#search'
  end
end
