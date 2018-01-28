# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string
#  local_currency  :string
#
# Indexes
#
#  index_users_on_email  (email)
#

class User < ApplicationRecord
  has_secure_password
end
