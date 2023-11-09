Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :contacts
  resources :students do
    member do
      get "recent_lessons", defaults: { format: :turbo_stream }
    end
    resources :lessons do
      collection do
        get 'bulk_new'
        post 'bulk_create'
        get 'select_delete'
        delete 'bulk_delete'
      end
    end
  end
  resources :calendars
  devise_for :users, :controllers => { registrations: 'users/registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "users#dashboard"

   get "dashboard", to: "users#dashboard", as: "dashboard"

   get "subscribe/:id", to: "calendar#serve", as: "subscription"
end
