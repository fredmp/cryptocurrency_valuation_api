class ApplicationController < ActionController::API

  # before_action :set_dev_credentials, :if => proc { Rails.env.development? }
  before_action :authenticate!
  after_action :set_authentiation_header!

  private

  def authenticate!
    render json: { error: 'Not Authorized' }, status: 401 unless current_user
  end

  def set_authentiation_header!
    response.headers['Authorization'] = JsonWebToken.encode(current_user) if current_user
  end

  def decoded_auth_token
    @decoded_auth_token ||= (JsonWebToken.decode(request.headers['Authorization']) rescue nil)
  end

  def current_user
    @current_user ||= (User.find(decoded_auth_token[:user_id]) if decoded_auth_token)
  end

  def set_current_user(user)
    @current_user = user
  end

  def set_dev_credentials
    unless ['register', 'login'].include?(controller_name) && action_name == 'create'
      set_current_user(User.first)
    end
  end
end
