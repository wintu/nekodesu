class Api::SearchController < ApplicationController

  def title
    data_set = DataSet.where('title LIKE ?', "%#{params[:q]}%")
    render json: { ok: 1, result: ActiveModel::SerializableResource.new(data_set) }
  end

  def category
    data_set = DataSet.find_by(category_id: params[:q])
    render json: { ok: 1, result: ActiveModel::SerializableResource.new(data_set) }
  end

  def tag
    return render_404 if params[:q].blank?
    tag_names = params[:q].split(',')
    data_set = DataSet.where(tags: { name: tag_names }).includes(:tags)

    render json: { ok: 1, result: ActiveModel::SerializableResource.new(data_set) }
  end
end
