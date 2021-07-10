class UserSessionsController < ApplicationController
  before_action 
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(user_session_params.to_h)
    if @user_session.save
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    redirect_back fallback_location:root_url #to new_user_session_url
  end
  
  private
  
  def user_session_params
    params.require(:user_session).permit(:login, :password)
  end
end

