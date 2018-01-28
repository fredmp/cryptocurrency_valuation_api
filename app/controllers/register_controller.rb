class RegisterController < ApplicationController

  skip_before_action :authenticate!, only: [:create]

  def create
    if User.find_by(email: params[:email])
      render json: { message: "This email is already in use" }, status: :bad_request
      return
    end

    user = User.new(email: params[:email], password: params[:password])
    if user.save
      set_current_user(user)
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
