Rails.application.routes.draw do
  root "spendings#index"

  devise_for :users

  resources :users do
    resources :spendings do
      resources :shared_users
    end
    resources :shared_spendings, only: [:index]
  end
end
