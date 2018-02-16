# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  source       :string
#  author       :string
#  title        :string
#  description  :string
#  url          :string
#  image_url    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  published_at :datetime
#

class Article < ApplicationRecord
end
