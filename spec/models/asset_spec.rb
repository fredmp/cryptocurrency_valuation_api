require 'rails_helper'

RSpec.describe Asset, type: :model do

  it { is_expected.to belong_to(:currency) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to respond_to(:amount) }
  it { is_expected.to respond_to(:btc_value) }
  it { is_expected.to respond_to(:usd_value) }

end
