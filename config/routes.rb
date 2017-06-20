Rails.application.routes.draw do
  root "time_frames#index"

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
