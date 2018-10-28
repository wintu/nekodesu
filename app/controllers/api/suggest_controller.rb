class Api::SuggestController < ApplicationController
  def category
    categories = Category.all
    render json: categories
  end

  def tag
    tags = Tag.where('name LIKE ?', "%#{params[:keyword]}%").limit(10)
    render json: tags
  end

  def title
    data_sets = DataSet.where('title LIKE ?', "%#{params[:keyword]}%").limit(10)
    render json: data_sets
  end
end
