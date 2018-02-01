class StatusController < ApplicationController

  skip_before_action :authenticate!, only: ['index']

  def index
    begin
      ActiveRecord::Base.connection.current_database
      render json: { status: 'ok' }, status: 200
    rescue
      head 503
    end
  end
end
