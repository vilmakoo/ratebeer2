Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['7bfb80ba63abbec0fcab'], ENV['16843d0235fddca1e4ad5cf44ea7c9f6f49ba7c6']
end