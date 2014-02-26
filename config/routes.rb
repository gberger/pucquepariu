Pqp::Application.routes.draw do

  resources :study_materials, except: [:index, :show]
  resources :courses, path: "disciplinas"
  get '/disciplinas/:course_abbreviation/study_materials', to: 'study_materials#show', as: 'course_study_materials'

  root 'static#index'
  get "index", to: 'static#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get "users", to: 'users#index'
  put "users/:id/edit_role", to: 'users#edit_role', as: 'edit_role'
end
