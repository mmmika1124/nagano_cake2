class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    @total = @cart_items.inject(0){|total,cart_item|total + cart_item.subtotal}
    @sum = @order.shipping_cost + @total
    if params[:order][:select_address] == "0"
      @order.postal_code = @customer.postal_code
      @order.address = @customer.address
      @order.name = @customer.last_name + @customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.postal_code = order_params[:postal_code]
      @order.address = order_params[:address]
      @order.name = order_params[:name]
    end
  end

  def create
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
