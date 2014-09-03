class Api::V1::FriendsController < Api::V1::ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends
  # GET /friends.json
  def index
            @message = 'Hello World'
        @friends= []
        @friends = session[:friends] unless session[:friends].nil?
        @facebook_api_token = session[:facebook_api_token]
        begin
            @facebook_api = Koala::Facebook::API.new(@facebook_api_token)
            education  = @facebook_api.get_object("me") { |data| data['education'] }
            @me = @facebook_api.get_object("me")
            
            Rails.logger.info @facebook_api_token
            
 
            
            @friends = @facebook_api.get_connections('me','friends',:fields=>"name,gender,relationship_status, picture").sample(8)
            Rails.logger.info @facebook_api.methods
        rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
        else
            # other exception
        ensure
            # always executed
        end
    render json: @friends
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  # POST /friends.json
  def create
    @user_friend_adjective = UserFriendAdjective.new(:user_id => session[:user_id], :friend_id => params[:friend_id], :adjective_id => params[:adjective_id])

    if @user_friend_adjective.save
      render json: @user_friend_adjective

    else
        render json: @user_friend_adjective.errors, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: 'Friend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params[:friend]
    end
end
