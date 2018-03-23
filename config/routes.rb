Rails.application.routes.draw do
  resources :scores, only: [:index, :create]
  get :scoreless, to: 'scores#scoreless'

  resources :users, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post :reverse, to: 'reverse#reverse', as: 'reverse'
end
