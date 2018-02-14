require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'password_recovery' do
    let(:user) { create(:user) }
    let(:mail) { described_class.password_recovery(user).deliver_now }

    it 'renders the email' do
      expect(mail.subject).to eq('CryptoCurrency Valuation Tool - Password Recovery')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ENV['EMAIL_FROM']])
      expect(mail.body.encoded).to match("#{user.token}")
    end
  end
end
