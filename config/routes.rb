Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games do
    member do
      get '/finish', to: 'games#finish'
    end
    get 'test_scrap', to: 'games#test_scrap', as: :test_scrap
  end
end
