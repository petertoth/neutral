class UsersController < ApplicationController

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
