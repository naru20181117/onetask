Rails.application.routes.draw do
  root 'tasks#index'
  namespace :admin do
    resources :users
  end
  resources :tasks do
    post :import, on: :collection
  end
  resources :users
  get '/each_user', to: 'each_user#index'
  post '/tasks/:id/done' => 'tasks#done', as: 'done'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
