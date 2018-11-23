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
    getTotals()
  end

  def change_quantity
    session[:cart] ||= {}
    id = params[:id]
    session[:cart][id] = {quantity: params[:quantity]}
    redirect_back fallback_location: root_path
  end

  def checkout
    user = User.find(session[:userid])

    if user
      getTotals()

      order = Order.create({:user_id => session[:userid], :total => @total, :status => "Pending"})

      # Save order into session
      session[:order] = order.id

      # Create the food orders
      createFoodsOrders

      redirect_to '/foods/checkout_success'
    else
      flash[:message] = "Order was not successful"

      redirect_back fallback_location: root_path
    end
  end

  def checkout_success
    getTotals()

    session[:total] = @total
    session.delete(:cart)
  end

  def pay
    # Amount in cents
    @amount = ((session[:total].to_f) * 100).round
  
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'cad'
    )

    redirect_to '/foods/payment_successful'
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def payment_successful
    order = Order.find(session[:order])

    order.status = "Paid"

    order.save
  end

  private
  def getTotals
    @foods = []
    @total = 0
    session[:cart].keys.each do |key|
      food = Food.find(key);
      @foods.push(food);
      @total += food.price * session[:cart]["#{food.id}"]["quantity"].to_i
    end

    @subtotal = @total
    
    if session[:userid]
      user = User.find(session[:userid])
      @taxRate = user.province.taxes * 100
      @totalTaxes = user.province.taxes * @total

      @total += @totalTaxes
    end
  end

  private
  def createFoodsOrders
    session[:cart].keys.each do |key|
      food = Food.find(key);
      quantity = session[:cart]["#{food.id}"]["quantity"].to_i

      foodsOrder = FoodsOrder.create({:order_id => session[:order], :food_id => food.id, :quantity => quantity})
    end
  end
end
