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
    elsif !user.activated? # rails method
      flash.now[:errors] = ['You must activate account first, check email.']
      render :new
    else
      login!(user) # if its the person, log them in
      redirect_to root_url #
    end
     # what is root_url?
  end


  def destroy
    current_user.reset_session_token
    session[:session_token] = nil
    redirect_to new_session_url # redirect to sign in page
  end

  # should reset session_token and session[:session_token]
  # redirect them to User#show page, showing that user email
end

# user actived a method that rails gives you for free
