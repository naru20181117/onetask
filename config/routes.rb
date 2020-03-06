Rails.application.routes.draw do
  root 'tasks#show'
  get 'tasks/new'
  # get 'tasks/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
