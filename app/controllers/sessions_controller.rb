class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(session_params[:name], session_params[:password])
    if user
      login(user)
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    logout(current_user)
    session[:session_token] = nil
    redirect_to root_url
  end

  private

  def session_params
    params.require(:user).permit(:name, :password)
  end
end
