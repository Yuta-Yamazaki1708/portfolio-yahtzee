Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  get "/user/mypage/:id", to: "users/mypage#show", as: "mypage"
  get "/user/mypage/edit/:id", to: "users/mypage#edit", as: "mypage_edit"
  patch "user/mypage/update", to: "users/mypage#update", as:"mypage_update"

end
