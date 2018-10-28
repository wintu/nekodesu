class DatumSerializer < ActiveModel::Serializer
  attributes :ok, :body, :display_type, :target_label

  def body
    object.convert_hash
  end

  def ok() 1 end
end
