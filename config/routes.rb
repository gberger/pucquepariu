Pqp::Application.routes.draw do

  root 'static#index'
  get "index", to: 'static#index'

end
