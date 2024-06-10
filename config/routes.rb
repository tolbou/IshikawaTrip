Rails.application.routes.draw do
  root 'static_pages#home'
  get 'layouts/application'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  get 'mypage', to: 'users#show', as: 'mypage'
  get 'mypage/my_posts', to: 'users#my_posts', as: 'my_posts'
  get 'mypage/liked_posts', to: 'users#liked_posts', as: 'liked_posts'
  resources :sessions, only: %i[create destroy]
  resources :users, only: [:update] do
    member do
      get 'posts', to: 'posts#index', as: 'posts'
      get 'liked_posts', to: 'posts#liked', as: 'liked_posts'
    end
  end

  # 投稿に対するRESTfulルーティングを生成する
  resources :posts, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    # 個別の投稿に対するlikeアクションを追加する
    member do
      post 'like' # POSTリクエストを受け取る
    end
  end

  resources :users, only: [:show, :update]

  get 'before_login', to: 'static_pages#before_login', as: 'before_login'

  # 最後に消す
  match '/_next/*path', to: proc { [200, {}, ['']] }, via: :all
end
