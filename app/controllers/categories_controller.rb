class CategoriesController < ApplicationController

  # Show 
  def show
    @name = params[:name]
    @cat = Category.where('lower(name) = ?', @name.downcase).first
    @id

    if @cat.present?
      @id= @cat.id
    end

    @foods = Food.where(category_id: @id).page(params[:page]).per(1)

    if !@foods.present?
      redirect_to root_path
    end
  end
end
