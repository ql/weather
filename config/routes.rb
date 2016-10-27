Rails.application.routes.draw do
  resources :fields, format: :json
  post   "users/sign_up"
  post   "users/sign_in"
  get    "users/sign_out"
  patch  "users/update"
  delete "users/update"
end
