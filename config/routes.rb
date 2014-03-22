Pqp::Application.routes.draw do

  resources :courses, path: "disciplinas" do
    resources :study_materials, only: [:index, :create, :destroy]
  end

  root 'static#index'
  get 'index', to: 'static#index'
  get 'ping', to: 'static#ping'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get "users", to: 'users#index'
  put "users/:id/role", to: 'users#role', as: 'role'
end
