Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "905429006237776", "238188328440b9b8e7ffa7a4e551c368"
end