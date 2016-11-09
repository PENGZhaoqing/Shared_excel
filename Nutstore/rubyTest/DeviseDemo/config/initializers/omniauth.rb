Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, "365597612", "064adf13751b857c099e1f5d62796afd"
end