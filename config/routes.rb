Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "products#index"


  resources :products 
  resources :purchaseds, only: [:index, :create]
  end
end
