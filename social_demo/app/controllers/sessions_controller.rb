class SessionsController < ApplicationController
  def create
   
    Rails.logger.info auth_hash
    user = User.from_omniauth(auth_hash)
    session[:friends] = @friends
    session[:user_id] = user.id
    session[:facebook_api_token] = auth_hash.credentials.token
    redirect_to root_url
  end
  
  def auth_hash
    request.env['omniauth.auth']
  end

  def destroy
    session[:user_id] = nil
     session[:friends] = nil
    session[:facebook_api_token] = nil
    redirect_to root_url
  end
end