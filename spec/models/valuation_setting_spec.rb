require 'rails_helper'

RSpec.describe ValuationSetting, type: :model do

  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:max_value) }
  it { is_expected.to respond_to(:weight) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:valuations) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:max_value) }
  it { is_expected.to validate_presence_of(:weight) }
  it { is_expected.to validate_numericality_of(:weight) }
  it { is_expected.to validate_inclusion_of(:max_value).in_range(1..10) }

end
