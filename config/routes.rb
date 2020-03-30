Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  post '/tasks/:id/done' => 'tasks#done', as: 'done'
end
