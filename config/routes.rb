Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  
  devise_scope :user do
    get "/user/profile/:id", to: "users/registrations#show_profile", as: "profile"
    get "/user/edit_profile/:id", to: "users/registrations#edit_profile", as: "edit_profile"
    patch "user/updatep_profile/id", to: "users/registrations#update_profile", as: "update_profile"
  end
  

end
