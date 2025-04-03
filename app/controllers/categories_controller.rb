class CategoriesController < ApplicationController
  def new
  end

  def search
    item = Category.find(params[:id])
    children_item = item.children
    render json:{ item: children_item }
  end
end
