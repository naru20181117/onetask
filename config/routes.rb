Rails.application.routes.draw do
  root 'tasks#index'
  namespace :admin do
    resources :users
  end
  resources :tasks
  resources :users
  post '/tasks/:id/done' => 'tasks#done', as: 'done'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
