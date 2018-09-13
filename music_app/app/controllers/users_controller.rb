class UsersController < ApplicationController
  def show
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params) # should be logged in immediately after signing up

    if @user.save
      # ApplicationMailer.activation_email(@user).deliver_now!
      flash[:notice] = 'Succesfully created an account!'
      redirect_to new_session_url
      # logs in immediately
      # if succesful login direct to new session page
    else
      flash.now[:errors] = @user.errors.full_messages # print error messages
      render :new # redirect to new sign up page
      # if its not succesful login
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
    # only allow for email and password to go to user
    # pass along to create
  end

end
