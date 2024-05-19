# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'

  get 'layouts/application'
  get 'static_pages/after_login'
  get '/after_login', to: 'static_pages#after_login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]

  # RESTfulルーティングを生成する(7つのrouteを通す)
  resources :posts
end
