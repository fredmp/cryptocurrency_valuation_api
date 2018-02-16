class ArticlesController < ApplicationController

  skip_before_action :authenticate!, only: ['batch_update', 'index']

  def index
    render json: Article.order(published_at: :desc).limit(20), status: :ok
  end

  def batch_update
    received_token = request.headers['Authorization']
    unless received_token && received_token == ENV['ADMIN_TOKEN']
      render json: { error: 'Not Authorized' }, status: :not_authorized
      return
    end
    
    result = ArticlesUpdater.new("#{ENV['NEWS_API_URL']}#{ENV['NEWS_API_KEY']}").execute

    render json: result, status: (result[:status] == :success) ? :ok : :internal_server_error
  end
end
