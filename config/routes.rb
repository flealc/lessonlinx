Rails.application.routes.draw do
  resources :contacts
  resources :students do
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
   #get "student_lessons/:id", to: "students#student_lessons", as: "student_lessons"
   #get "lessons_student/:id", to: "lessons#lessons_student", as: "lessons_student"
   get "subscribe/:id", to: "calendar#serve", as: "subscription"
end
