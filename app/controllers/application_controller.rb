class ApplicationController < ActionController::API

  before_action :authenticate!
  after_action :set_authentiation_header!

  private

  def authenticate!
    render json: { error: 'Not Authorized' }, status: 401 unless current_user
  end

  def set_authentiation_header!
    if current_user
      token = JsonWebToken.encode(current_user)
      current_user.update_attribute(:token, token)
      response.headers['Authorization'] = token
    end
  end

  def decoded_auth_token
    @decoded_auth_token ||= (JsonWebToken.decode(request.headers['Authorization']) rescue nil)
  end

  def current_user
    return @current_user if @current_user
    user = User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @current_user = user if user && valid_token?(user)
  end

  def set_current_user(user)
    @current_user = user
  end

  def valid_token?(user)
    user.token == request.headers['Authorization']
  end
end
