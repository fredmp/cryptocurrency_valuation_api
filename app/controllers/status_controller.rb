class StatusController < ApplicationController
  def index
    begin
      ActiveRecord::Base.connection.current_database
      render json: { status: 'ok' }, status: 200
    rescue
      head 503
    end
  end
end
