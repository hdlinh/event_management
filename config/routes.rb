Rails.application.routes.draw do

  root to: "time_frames#index"
  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations"
  }

  devise_scope :user do
    get "register", to: "registrations#new"
    post "register", to: "registrations#create"
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "sign_in", to: "sessions#destroy"
  end

  resources :users
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

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
