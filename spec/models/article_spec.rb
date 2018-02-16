require 'rails_helper'

RSpec.describe Article, type: :model do

  it { is_expected.to respond_to(:source) }
  it { is_expected.to respond_to(:author) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:url) }
  it { is_expected.to respond_to(:image_url) }

end
