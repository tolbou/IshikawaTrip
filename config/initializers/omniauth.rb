# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  {
    scope: 'email, profile',
    # 本番環境用
    redirect_uri: 'https://ishikawatrip.onrender.com/auth/google_oauth2/callback'
  }
end
OmniAuth.config.allowed_request_methods = %i[post]
