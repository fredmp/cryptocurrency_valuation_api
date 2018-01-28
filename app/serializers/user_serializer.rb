class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :local_currency
end
