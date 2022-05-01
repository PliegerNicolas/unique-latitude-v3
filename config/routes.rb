Rails.application.routes.draw do
  root 'pages#index'

  resources :projects do
    resources :media, only: %i[ new edit create update destroy ]
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
