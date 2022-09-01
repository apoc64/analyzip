Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret], {
    :name => "google",
    :scope => ['email','profile'],
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50,
    :access_type => 'offline'
  }
end

OmniAuth.config.allowed_request_methods = [:post, :get]