class DatumSerializer < ActiveModel::Serializer
  attributes :ok, :body

  def body
    object.convert_hash
  end

  def ok() 1 end
end
