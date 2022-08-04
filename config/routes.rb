Rails.application.routes.draw do
  root to: 'site#index'
  get 'spa/foo', to: 'site#index'
  get 'spa/bar', to: 'site#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
