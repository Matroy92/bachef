Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games do
    member do
      get '/finish', to: 'games#finish'
      patch '/saved', to: 'games#saved'
    end
    
  end
  resources :cards
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end
end
