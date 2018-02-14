class UserMailer < ApplicationMailer
  
  def password_recovery(user)
    @user = user
    @url = password_recovery_url
    mail(to: @user.email, subject: 'CryptoCurrency Valuation Tool - Password Recovery')
  end

  private

  def password_recovery_url
    "#{ENV['FRONT_URL']}/redefine-password?token=#{@user.token}"
  end
end
