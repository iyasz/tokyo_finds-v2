Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "client/home#index"

  # AUTHENTICATION ROUTE
  get "/login", to: "auth/auth#loginView"
  post "/login", to: "auth/auth#loginHandle"

  get '/auth/:provider/callback', to: 'auth/auth#google_auth'
  get '/auth/failure', to: redirect('/login')

  get "/register", to: "auth/auth#registerView"
  post "/register", to: "auth/auth#registerHandle"

  get "/confirm_email/:token", to: "auth/auth#confirm_email", as: :confirm_email
  get "/resend_confirmation/:token", to: "auth/auth#resend_confirmation", as: :resend_confirmation

  delete "/logout", to: "auth/auth#logout"


  # ADMIN ROUTE
  get "/app/dashboard", to: "admin/dashboard#index"

  get "/app/products", to: "admin/product#index"
  get "/app/product/new", to: "admin/product#create"

  scope "/app", module: "admin" do
    resources :brands, except: :show, controller: "brand"
  end

  scope "/app", module: "admin" do
    resources :series, except: :show, controller: "series"
  end

  scope "/app", module: "admin" do
    resources :characters, except: :show, controller: "character"
  end

  # scope "/app", module: "admin" do
  #   resources :brands, except: :show, controller: "brand"
  # end


  # ERROR HANDLE 
  match "*path", to: "application#render_not_found", via: :all


  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
