class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :daily_score, :latest_score
end
