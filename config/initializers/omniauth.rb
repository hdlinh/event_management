OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["google_app_id"], ENV["google_secret"], {
      access_type: 'offline',
      prompt: 'select_account consent',
      scope: 'email, profile',
      provider_ignores_state: true,
      image_size: 40
    }
end
