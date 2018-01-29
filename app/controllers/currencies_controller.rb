class CurrenciesController < ApplicationController

  skip_before_action :authenticate!, only: ['batch_update']

  def index
    render json: Currency.limit(300), status: :ok
  end

  def batch_update
    received_token = request.headers['Authorization']
    unless received_token && received_token == ENV['ADMIN_TOKEN']
      render json: { error: 'Not Authorized' }, status: :not_authorized
      return
    end
    unless params[:offset]
      render json: { error: 'offset is required' }, status: :bad_request
      return
    end

    result = DataUpdater.new(ENV['SOURCE_URL'], params[:offset]).execute

    status = case result[:status]
    when :success then :ok
    when :partial_failure then :partial_content
    when :failure then :internal_server_error
    end

    render json: result.to_json, status: status
  end
end
