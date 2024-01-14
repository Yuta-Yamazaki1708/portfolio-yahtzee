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

  post "/new_game", to: "games#new_game", as: "new_game"
  get "/game/:id", to: "games#game", as: "game"
  post "/roll_dices", to: "games#roll_dices", as: "roll_dices"
  post "/move_to_keep", to: "games#move_to_keep", as: "move_to_keep"
  post "/move_to_table", to: "games#move_to_table", as: "move_to_table"
  post "/select_category", to: "games#select_category", as: "select_category"
end
