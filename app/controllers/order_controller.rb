class OrderController < ApplicationController
  def index
    @orders = Order.where({user_id: session[:userid]}).order(id: :desc)
  end

  def show
    @order = Order.find(params[:id])

    @foodsOrders = FoodsOrder.where({order_id: params[:id]})
  end
end
