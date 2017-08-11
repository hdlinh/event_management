Rails.application.routes.draw do

  resources :members

  # get "member_login", to: "sessions#member_login", as: "member_login"
  # post "member_login", to: "sessions#create_member_login", as: "create_member"
  # get "member_logout", to: "sessions#member_logout", as: "member_logout"



  root to: "time_frames#index"

  #get "auth/:provider/callback", to: "sessions#omniauth_create"
  #get "auth/failure", to: redirect("/")
  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # resources :users
  namespace :admin do
    resources :users
    match "/users/destroy", to: "user#destroy", via: [:delete], as: :destroy_users_path
    # match "/sessions/user", to: "sessions#omniauth_create", via: [:post]
    resources :users do
      collection do
        delete "destroy"
      end
    end
  end



  devise_scope :user do
    get "register", to: "members#new"
    post "register", to: "members#create"
    get "member_login", to: "sessions#member_login"
    post "member_login", to: "sessions#create_member_login"
    get "/sessions/new.user", to: "registrations#new"
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "sign_out", to: "sessions#destroy"
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end



  match "/roles/destroy", to: "roles#destroy", via: [:delete], as: :destroy_roles_path
  resources :roles
  resources :roles do
    collection do
      delete "destroy"
    end
  end

  match "/time_frames/destroy", to: "time_frames#destroy", via: [:delete], as: :destroy_time_frames_path
  resources :time_frames
  resources :time_frames do
    collection do
      delete "destroy"
      get   "list"
    end
  end
  match "/speakers/destroy", to: "speakers#destroy", via: [:delete], as: :destroy_speakers_path
  resources :speakers
  resources :speakers do
    collection do
      delete "destroy"
    end
  end
   match "/events/destroy", to: "events#destroy", via: [:delete], as: :destroy_events_path
  resources :events
  resources :events do
    collection do
      delete "destroy"
    end
  end
  match "/rooms/destroy", to: "rooms#destroy", via: [:delete], as: :destroy_rooms_path
  resources :rooms
  resources :rooms do
  	collection do
  	  delete "destroy"
  	end
  end

end
