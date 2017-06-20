json.extract! room, :id, :ro_name, :ro_type, :created_at, :updated_at
json.url room_url(room, format: :json)
