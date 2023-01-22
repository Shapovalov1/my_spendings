Rails.application.routes.draw do
  root "spendings#new"

  devise_for :users
  resources :spendings
end
