Rails.application.routes.draw do
  resources :users, only: %i[index show]

  resources :scores, only: %i[index create]
  get :scoreless, to: 'scores#scoreless'

  post :reverse, to: 'reverse#reverse', as: 'reverse'
end
