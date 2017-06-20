Rails.application.routes.draw do
  match "/speakers/destroy", to: "speakers#destroy", via: [:delete], as: :destroy_speakers_path
  resources :speakers
  resources :events
  match "/rooms/destroy", to: "rooms#destroy", via: [:delete], as: :destroy_rooms_path
  resources :rooms
  resources :rooms do
  	collection do
  	  delete "destroy"
  	end
  end
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
