Rails.application.routes.draw do
  root "spendings#new"

  devise_for :users

  get 'spendings', to: 'spendings#index', as: 'spendings'
  post 'spendings', to: 'spendings#create'
  get 'spendings/:id/edit', to: 'spendings#edit', as: 'edit_spending'
  patch 'spendings/:id', to: 'spendings#update'
  delete 'spendings/:id', to: 'spendings#destroy'
  resources :spendings
end
