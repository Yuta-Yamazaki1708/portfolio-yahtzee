Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  root "home#index"
  
  devise_scope :user do
    post "user/guest_sign_in", to: "users/sessions#guest_sign_in", as: "guest_sign_in"
  end

  get "/user/profile/:id", to: "users/mypages#show", as: "profile"
  get "/user/edit_profile", to: "users/mypages#edit", as: "edit_profile"
  patch "user/update_profile", to: "users/mypages#update", as: "update_profile"
  get "/select_players_num", to: "games#select_players_num", as: "select_players_num"
  post "/new_game", to: "games#new_game", as: "new_game"
  get "/game", to: "games#game", as: "game"
  get "/roll_dices", to: "games#roll_dices", as: "roll_dices"
  get "/move_to_keep", to: "games#move_to_keep", as: "move_to_keep"
  get "/move_to_table", to: "games#move_to_table", as: "move_to_table"
  patch "/select_category", to: "games#select_category", as: "select_category"
  get "/get_roll_count", to: "games#get_roll_count"
  get "/result/:id", to: "results#show", as: "result"
  delete "/result/:id", to: "results#destroy"
  get "/ranking", to: "ranks#all", as: "ranking"
  get "/ranking/weekly", to: "ranks#weekly", as: "weekly_ranking"
  get "/rules", to: "rules#index", as: "rules"
  get "posts", to: "posts#new", as: "new_post"
  post "posts", to: "posts#create", as: "post"
  delete "/delete_post/:id", to: "posts#destroy", as: "delete_post"
end
