Rails.application.config.middleware.use OmniAuth::Builder  do
  configure do |config|
    config.path_prefix = '/auth'
  end

	provider :facebook, '1187571584693235', '84ba0bfb86dfd44d5894f034c915bd62'
	provider :salesforce, "3MVG9YDQS5WtC11rEEbuE0ugmmxoFqE2nwkWgPIMnmmss56M7Lc90J0wULBI3_zBVbQy7Fh9ralCsTnz7DGt6", "201586777941315632"

end