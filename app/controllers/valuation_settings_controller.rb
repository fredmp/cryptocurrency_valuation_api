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

  def batch_create
    result = nil
    ValuationSetting.transaction do
      begin
        settings = []
        params[:batch].each do |setting_params|
          new_valuation_setting = ValuationSetting.new(
            name: setting_params[:name],
            description: setting_params[:description],
            max_value: setting_params[:max_value],
            weight: setting_params[:weight],
            user: current_user
          )
          new_valuation_setting.save!
          TrackedCurrency.where(user: current_user).each do |t|
            t.valuations.create(value: 0, valuation_setting: new_valuation_setting)
          end
          settings << new_valuation_setting
        end
        result = { json: settings, status: :created }
      rescue => e
        result = { json: { message: e.message }, status: :internal_server_error }
      end
    end
    render result
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
