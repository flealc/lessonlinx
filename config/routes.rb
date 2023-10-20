Rails.application.routes.draw do
  resources :lessons
  resources :contacts
  resources :students
  resources :calendars
  devise_for :users, :controllers => { registrations: 'users/registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "users#dashboard"

   get "dashboard", to: "users#dashboard", as: "dashboard"
   get "student_lessons/:id", to: "students#student_lessons", as: "student_lessons"
end
