Rails.application.routes.draw do
  devise_for :users,  controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "recipes#public_recipes"
  get 'users', to: 'users#index', as: 'users_index'

  resources :foods, only: %i[index new create destroy]
  resources :recipes, only: %i[index new create destroy show edit update ] do
    resources :recipe_foods, only: %i[new create destroy edit update]
  end
  get 'recipes/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
end
