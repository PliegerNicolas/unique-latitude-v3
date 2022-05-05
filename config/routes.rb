Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users

  get 'users', to: 'users#index', as: :users
  get 'users/:id/promote', to: 'users#promote', as: :promote
  get 'users/:id/demote', to: 'users#demote', as: :demote


  resources :projects do
    resources :media
    get 'media/:id/cancel', to: 'media#cancel', as: :medium_cancel
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
