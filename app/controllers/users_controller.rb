class UsersController < ApplicationController

  skip_before_action :authenticate!, only: [:create]

  def create
    if User.find_by(email: params[:email])
      render json: { message: "This email is already in use" }, status: :bad_request
      return
    end

    user = User.new(user_params)
    if user.save
      set_current_user(user)
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    unless user
      render json: { message: "User does not exist" }, status: :bad_request
      return
    end

    if user_params[:password] && !user.authenticate(user_params[:password])
      render json: { message: 'Invalid password' }, status: :unauthorized
    end

    if user.update_attributes(user_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :local_currency)
  end
end
