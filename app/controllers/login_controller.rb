class LoginController < ApplicationController

  skip_before_action :authenticate!

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      set_current_user(user)
      render json: user, status: :ok
    else
      render json: { message: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
