class Api::SearchController < ApplicationController

  def title
    data_set = DataSet.where('title LIKE ?', "%#{params[:title]}%")
    render json: { ok: 1, result: ActiveModel::SerializableResource.new(data_set) }
  end

  def category
    data_set = DataSet.find_by(category_id: params[:ca_id])
    data_set = DataSet.all if @categorys.blank? && params[:ca_id].blank?
    render json: { ok: 1, result: ActiveModel::SerializableResource.new(data_set) }
  end

  def tag
    return render_404 if params[:tag].blank?
    tag_names = params[:tag].split(',')
    data_set = DataSet.where(tags: { name: tag_names }).includes(:tags)

    render json: { ok: 1, result: ActiveModel::SerializableResource.new(data_set) }
  end
end
