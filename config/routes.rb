Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :employees
  resources :expenses, only: [:index, :show, :create]
  resources :invoices, only: [:index, :show, :create]
end
