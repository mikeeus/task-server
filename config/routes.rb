Rails.application.routes.draw do
  resources :scores, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post :reverse, to: 'reverse#reverse', as: 'reverse'
end
