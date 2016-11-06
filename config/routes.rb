Rails.application.routes.draw do
  resources :fields, format: :json do
    get :current_weather, on: :member
    get :future_weather, on: :member
  end
  post   "users/sign_up"
  post   "users/sign_in"
  get    "users/sign_out"
  patch  "users/update"
  delete "users/update"
end
