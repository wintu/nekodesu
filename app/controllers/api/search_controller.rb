class Api::SearchController < ApplicationController
  layout 'test'
  def index
    @categorys = Category.where(name: params[:name])
    @categorys = Category.all if @categorys.blank? && params[:name].blank?
  end
end
