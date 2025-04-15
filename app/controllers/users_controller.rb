class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]

  def new
    redirect_to root_path if current_user
    @user = User.new
  end

  def create
    @user = UserRegistration.new(permitted_params).call

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def permitted_params
    params.permit(:email, :password, :street, :city, :zip)
  end
end
