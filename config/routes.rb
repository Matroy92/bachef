Rails.application.routes.draw do
  
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games do
    member do
      get '/finish_show', to: 'games#finish_show'
      post '/finish', to: 'games#finish'
      patch '/saved', to: 'games#saved'
    end

  end
  resources :cards
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
