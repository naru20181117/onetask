Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users
  post '/tasks/:id/done' => 'tasks#done', as: 'done'
  get '/login', to: 'sessions#new'
end
