Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  resources :events, only: %i[index show]
  resources :assos, only: %i[show new create] do
    get :dashboard, on: :member
    resources :events, only: [ :new, :create ]
  end
  resources :participations, only: %i[create] do
    member do
      patch '/accepted', to: 'participations#accepted'
      patch '/denied', to: 'participations#denied'
      patch '/cancelled', to: 'participations#cancelled'
    end
  end
  get :profiles, to: 'profiles#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
