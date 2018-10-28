class Api::FileController < ApplicationController
  require 'csv'
  protect_from_forgery except: [:upload, :details]

  def upload
    body = File.read(params[:upload_file].path).encode(Encoding::UTF_8, undef: :replace, invalid: :replace)
    csv = CSV.parse(body.sub(/\A\uFEFF/, ""), headers: true)

    tag_names = []
    if params[:tags].present?
      tag_names = params[:tags].split(',')
    end

    data_set = nil
    ActiveRecord::Base.transaction do
      data_set = DataSet.new
      data_set.title = params[:title]
      data_set.description = params[:description]
      data_set.link = params[:link]
      data_set.user_id = session[:user_id]
      data_set.category_id = params[:category_id]
      data_set.save!

      tag_names.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        TagRelate.create!(data_set_id: data_set.id, tag_id: tag.id)
      end

      datum = Datum.new
      datum.body = csv.to_s
      datum.data_set_id = data_set.id
      datum.display_type = params[:display_type]
      datum.target_label = params[:target_label]
      datum.save!
    end
      render json: { ok: 1, data_set_id: data_set.id }
  end

  def details
    data_set = DataSet.find(params[:id])
    render json: { ok: 1, result: ActiveModel::SerializableResource.new(data_set) }
  end

  def data
    datum = Datum.find_by(data_set_id: params[:id])
    render json: { ok: 1, result: ActiveModel::SerializableResource.new(datum) }
  end

  def download
    datum = Datum.find(params[:id])
    send_data datum.body, type:'text/csv; charset=shift_jis'
  end

  def destroy
    data = DataSet.find(params[:id])
    data.destroy
  end

end