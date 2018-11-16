class FoodsController < ApplicationController
  def index
    @foods = Food.page(params[:page]).per(5)
  end

  def show
    @food = Food.find(params[:id])
  end

  def search_results
    # Search for all foods if the category id is -1, otherwise limit to the category
    if params[:category].to_i == -1
      @foods = Food.where("name LIKE ?", "%#{params[:q]}%").
        page(params[:page]).per(5)
    else
      @foods = Food.where("name LIKE ?", "%#{params[:q]}%").
        where(category_id: params[:category]).
        page(params[:page]).per(5)
    end
  end

  def add_to_cart
    session[:cart] ||= {}
    id = params[:id]
    session[:cart][id] = {quantity: 1}
    redirect_back fallback_location: root_path
  end

  def remove_from_cart
    session[:cart] ||= {}
    id = params[:id]
    session[:cart] = session[:cart].except(id)
    redirect_back fallback_location: root_path
  end

  def show_cart
    @foods = []
    @total = 0
    session[:cart].keys.each do |key|
      food = Food.find(key);
      @foods.push(food);
      @total += food.price * session[:cart]["#{food.id}"]["quantity"].to_i
    end
  end

  def change_quantity
    session[:cart] ||= {}
    id = params[:id]
    session[:cart][id] = {quantity: params[:quantity]}
    redirect_back fallback_location: root_path
  end
end
