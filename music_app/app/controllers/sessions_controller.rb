class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil? # if missing, give error
      flash.now[:errors] = ['Invalid credentials'] # error message
      render :new # send them back to login
    elsif !activated

    else

    end
  end
  # should reset session_token and session[:session_token]
  # redirect them to User#show page, showing that user email

  def destroy
    
  end
end

# user actived a method that rails gives you for free
