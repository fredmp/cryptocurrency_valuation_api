class ApplicationController < ActionController::API

  before_action :authenticate!
  after_action :set_authentication_header!

  private

  def authenticate!
    render json: { error: 'Not Authorized' }, status: 401 unless current_user
  end

  def set_authentication_header!
    if current_user
      token = JsonWebToken.encode(current_user)
      current_user.update_attribute(:token, token)
      response.headers['Authorization'] = token
    end
  end

  def decoded_auth_token(token = request.headers['Authorization'])
    @decoded_auth_token ||= (JsonWebToken.decode(token) rescue nil)
  end

  def current_user
    return @current_user if @current_user
    user = User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @current_user = user if user && (fresh_token?(decoded_auth_token[:exp]) || stored_token?(user))
  end

  def set_current_user(user)
    @current_user = user
  end

  def stored_token?(user, received_token = request.headers['Authorization'])
    user.token == received_token
  end

  def fresh_token?(expiration_in_miliseconds)
    (Time.at(expiration_in_miliseconds) - 55.minutes) > Time.now
  end
end
