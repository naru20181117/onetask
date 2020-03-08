Rails.application.routes.draw do
  root 'tasks#list'
  resources 'tasks'
  # get '/tasks/show/:id', to: 'tasks#show', as: 'task'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
