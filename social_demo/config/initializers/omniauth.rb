OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '628436837276266', 'd8d08515ec591612f8139a61bbba602c',
        :scope => 'email,user_friends, user_relationships'
  
end