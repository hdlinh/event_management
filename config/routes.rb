Rails.application.routes.draw do

  get "admin", to: "admin#index"
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  devise_for :users, controllers: {
    sessions: "sessions"
  }

  devise_scope :user do
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    get "sign_in", to: "sessions#new"
    post "sign_in", to: "sessions#create"
  end

  resources :users

  root to: "time_frames#index"

  match "/users/destroy", to: "user#destroy", via: [:delete], as: :destroy_users_path
  resources :users
  resources :users do
    collection do
      delete "destroy"
    end
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
