Rails.application.routes.draw do
  get 'profile/edit_profile'
  post 'profile/edit_profile'

  get '/accounts', to: "accounts#signup"
  get '/accounts/signup'
  post "/accounts/signup"

  get "accounts/login"
  post "accounts/login"

  get "accounts/dashboard"
  get "accounts/logout"

  get "password/forgot_password"
  post "password/forgot_password"

  get "password/reset_password"
  post "password/reset_password"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
