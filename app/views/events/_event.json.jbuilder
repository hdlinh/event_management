json.extract! event, :id, :ev_name, :ev_description, :string, :ev_date, :created_at, :updated_at
json.url event_url(event, format: :json)
