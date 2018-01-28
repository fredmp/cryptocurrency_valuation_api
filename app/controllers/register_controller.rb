class RegisterController < ApplicationController
  def create
    if User.find_by(email: params[:email])
      render json: { message: "This email is already in use" }, status: :bad_request
      return
    end

    user = User.new(email: params[:email], password: params[:password])
    if user.save
      result = JsonWebToken.encode(user_id: user.id)
      response.headers['Authorization'] = result[:token]
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
