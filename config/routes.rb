Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  root "home#index"
  
  devise_scope :user do
    get "/user/profile/:id", to: "users/registrations#show_profile", as: "profile"
    get "/user/edit_profile", to: "users/registrations#edit_profile", as: "edit_profile"
    patch "user/update_profile", to: "users/registrations#update_profile", as: "update_profile"
    post "user/guest_sign_in", to: "users/sessions#guest_sign_in", as: "guest_sign_in"
  end
end
