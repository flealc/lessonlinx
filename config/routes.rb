Rails.application.routes.draw do
  resources :students
  resources :calendars
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "users#dashboard"
end
