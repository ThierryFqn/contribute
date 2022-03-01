Rails.application.routes.draw do
  get 'events/index'
  get 'events/show'
  get 'events/new'
  get 'events/create'
  devise_for :users
  root to: 'pages#home'
  resources :assos, only: %i[show new create] do
    get :dashboard, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
