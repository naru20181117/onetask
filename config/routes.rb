Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  root 'tasks#index'
  resources :tasks
  resources :users
  post '/tasks/:id/done' => 'tasks#done', as: 'done'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
