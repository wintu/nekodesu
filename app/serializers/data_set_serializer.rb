class DataSetSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_name, :category, :tags, :description, :link

  def user_name
    object.user.name
  end

  def category
    return nil if object.category.blank?
    { name: object.category.name, id: object.category.id }
  end

  def tags
    object.tags.map { |tag| { name: tag.name, id: tag.id } }
  end
end
