Rails.application.routes.draw do
  authenticate :user, ->(current_user) { current_user.admin? } do
    mount GoodJob::Engine => '/good_job'
    mount RailsDb::Engine => "/rails/db", :as => "rails_db"
  end

  resources :contacts
  resources :students do
    member do
      get "recent_lessons", defaults: { format: :turbo_stream }
    end
    resources :lessons do
      collection do
        get "bulk_new"
        post "bulk_create"
        get "select_delete"
        delete "bulk_delete"
      end
    end
  end
  resources :calendars

  devise_for :users, :controllers => { registrations: "users/registrations" }

  root "users#dashboard"

  get "dashboard", to: "users#dashboard", as: "dashboard"

  get "subscribe/:id", to: "calendar#serve", as: "subscription"
end
