Rails.application.routes.draw do
  authenticate :user, ->(current_user) { current_user.admin? } do
    mount RailsAdmin::Engine => "/admin", as: "rails_admin"
    mount GoodJob::Engine => "/good_job"
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

  devise_for :users, :controllers => { registrations: "users/registrations", passwords: "users/passwords" }

  
  devise_scope :user do
    
    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
    
    authenticated :user do
      root to: "users#dashboard", as: :authenticated_root
    end
    
  end

  get "dashboard", to: "users#dashboard", as: "dashboard"

  get "subscribe/:id", to: "calendar#serve", as: "subscription"
end
