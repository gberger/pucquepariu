Pqp::Application.routes.draw do

  resources :study_materials
  resources :exams
  resources :courses, path: "disciplinas"

  root 'static#index'
  get "index", to: 'static#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get "users", to: 'users#index'
  put "users/:id/toggle_admin", to: 'users#toggle_admin', as: 'toggle_admin'
end
