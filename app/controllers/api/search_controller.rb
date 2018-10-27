class Api::SearchController < ApplicationController
  layout 'test'
  def index
    @categorys = DataSet.find_by(category_id: params[:ca_id])
    @categorys = DataSet.all if @categorys.blank? && params[:name].blank?
    @datas = DataSet.where('title LIKE ?', "%#{params[:title]}%")
    if params[:tag].present?
      where_tag_a = params[:tag].split(',')
      # pluck('id')でIDの配列が生成できる
      @tags = Tag.select('id').where(name: where_tag_a)
      # relationを上手く使えば2回または1回で行ける
      @tags = TagRelate.select('data_set_id').where(id: @tags)
      @tags = DataSet.where(id: @tags)
    else
      @tags = nil
    end
  end
end
