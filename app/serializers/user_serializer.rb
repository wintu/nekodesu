class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :ok

  def ok() 1 end
end
