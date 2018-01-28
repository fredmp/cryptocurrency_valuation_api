class AuthController < ApplicationController

  skip_before_action :authenticate!, only: ['create']

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      set_current_user(user)
      render json: user, status: :ok
    else
      render json: { message: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def destroy
    current_user.update_attribute(:token, nil)
    set_current_user(nil)
  end
end
