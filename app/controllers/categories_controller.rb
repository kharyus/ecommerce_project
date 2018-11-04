class CategoriesController < ApplicationController
  def show
    @id = Category.find(params[:name])
    @foods = Food.where(category_id: @id)
  end
end
