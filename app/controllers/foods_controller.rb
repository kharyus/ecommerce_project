class FoodsController < ApplicationController
  def index
    @foods = Foods.all
  end

  def show
    @food = Foods.find(params[:id])
  end
end
