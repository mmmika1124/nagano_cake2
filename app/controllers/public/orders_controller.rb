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
    order = Order.new(order_params)
    cart_items = current_customer.cart_items
    order.save
    cart_items.each do |cart_item|
      order_detail = order.order_details.new
      order_detail.item_id = cart_item.item_id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.price
    end
    cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :price, :amount, :making_status)
  end

end
