class ValuationSettingsController < ApplicationController

  def index
    render json: ValuationSetting.all, status: :ok
  end

  def create
    valuation_setting = ValuationSetting.new(valuation_setting_params)
    if valuation_setting.save
      render json: valuation_setting, status: :created
    else
      render json: valuation_setting.errors, status: :unprocessable_entity
    end
  end

  def update
    valuation_setting = ValuationSetting.find(params[:id])
    if valuation_setting.update(valuation_setting_params)
      render json: valuation_setting, status: :ok
    else
      render json: valuation_setting.errors, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      valuation_setting = ValuationSetting.find(params[:id])
      valuation_setting.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  private

  def valuation_setting_params
    params.require(:valuation_setting).permit(:name, :description, :max_value, :weight)
  end
end
