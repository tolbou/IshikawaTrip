Rails.application.routes.draw do
  root 'static_pages#home'
  get 'layouts/application'
  get 'static_pages/after_login'
  get '/after_login', to: 'static_pages#after_login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  resources :sessions, only: %i[create destroy]

  # 投稿に対するRESTfulルーティングを生成する
  resources :posts do
    # 個別の投稿に対するlikeアクションを追加する
    member do
      post 'like' # POSTリクエストを受け取る
    end
  end


  # 最後に消す
  match '/_next/*path', to: proc { [200, {}, ['']] }, via: :all

end
