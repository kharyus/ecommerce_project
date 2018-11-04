class CategoriesController < ApplicationController
  def show
    @id = Category.find_by(name: params[:name])
    @foods = Food.where(category_id: @id).page(params[:page])
  end
end
