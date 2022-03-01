Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :assos, only: %i[show new create] do
    get :dashboard, on: :member
    resources :events, only: [ :new, :create ]
  end
  get :profiles, to: 'profiles#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
