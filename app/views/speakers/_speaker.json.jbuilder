json.extract! speaker, :id, :sp_firstname, :sp_lastname, :sp_major, :sp_email, :sp_phone, :sp_description, :sp_avatar, :created_at, :updated_at
json.url speaker_url(speaker, format: :json)
