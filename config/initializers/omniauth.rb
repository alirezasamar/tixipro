OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '371722583031184', 'b77b6535796a87c2f489be6e4a7554c9', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
