class ValuationSettingsController < ApplicationController

  def index
    render json: ValuationSetting.where(user: current_user), status: :ok
  end

  def create
    new_valuation_setting = ValuationSetting.new(valuation_setting_params)
    new_valuation_setting.user = current_user

    if new_valuation_setting.save
      TrackedCurrency.where(user: current_user).each do |t|
        t.valuations.create(value: 0, valuation_setting: new_valuation_setting)
      end

      render json: new_valuation_setting, status: :created
    else
      render json: new_valuation_setting.errors, status: :unprocessable_entity
    end
  end

  def update
    begin
      if valuation_setting.update(valuation_setting_params)
        render json: valuation_setting, status: :ok
      else
        render json: valuation_setting.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def destroy
    begin
      valuation_setting.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  private

  def valuation_setting
    @valuation_setting ||= ValuationSetting.where(user: current_user).find(params[:id])
  end

  def valuation_setting_params
    params.require(:valuation_setting).permit(:name, :description, :max_value, :weight)
  end
end
