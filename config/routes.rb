Rails.application.routes.draw do
  get 'post/index'
  get 'post/new'
  get 'post/create'
  get 'post/update'
  get 'post/destroy'

  root 'static_pages#home'

  get 'layouts/application'
  get 'static_pages/after_login'
  get '/after_login', to: 'static_pages#after_login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]
  # 解説/only.txt
  resources :posts, only: %i[index]

end
