Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :assos, only: %i[show new create] do
    get :dashboard, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events, only: [ :new, :create ]
end
