class Api::FileController < ApplicationController
  require 'csv'
  protect_from_forgery except: [:upload, :details]

  def upload
    body = File.read(params[:upload_file].path).encode(Encoding::UTF_8, undef: :replace, invalid: :replace)
    csv = CSV.parse(body, headers: true)

    data_set = nil
    ActiveRecord::Base.transaction do
      data_set = DataSet.new
      data_set.title = params[:title]
      data_set.description = params[:description]
      data_set.link = params[:link]
      data_set.user_id = session[:user_id]
      data_set.save!

      Datum.create!(body: csv.to_s, data_set_id: data_set.id, user_id: session[:user_id])
    end
      render json: { ok: 1, data_set_id: data_set.id }
  end

  def details
    data_set = DataSet.find(params[:id])
    render json: { ok: 1, result: ActiveModel::SerializableResource.new(data_set) }
  end

  def data
    datum = Datum.find(params[:id])
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