Rails.application.routes.draw do
  root 'pages#index'

  devise_for :users

  resources :projects do
    resources :media
  end

  get 'users', to: 'users#index', as: :users
  get 'users/:id/promote', to: 'users#promote', as: :promote
  get 'users/:id/demote', to: 'users#demote', as: :demote
  get 'projects/:id/change-status', to: 'projects#change_status', as: :project_change_status
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
