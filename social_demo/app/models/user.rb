class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    #Rails.logger.info auth
      #User.create( user_params(auth))
    #where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
     user = User.where(:uid => auth.uid, :provider => auth.provider).first
    
      user = User.new  if(user.nil?) 
     #   user.update_attributes(user_params(auth))
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.image = auth.info.image
      user.save!
      user
    #end
  end
  
  def self.user_params(auth)
    return { :provider => auth.provider, 
             :uid => auth.uid,
             :name => auth.info.name, 
             :oauth_token => auth.credentials.token, 
             :oauth_expires_at =>  Time.at(auth.credentials.expires_at)}
             .require(:user).permit(:provider, :uid, :name, :oauth_token, :oauth_expires_at)
  end
    
end