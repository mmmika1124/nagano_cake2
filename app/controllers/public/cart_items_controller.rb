class Public::CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.customer = current_customer
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
        redirect_to cart_items_path
    else
      if cart_item.save
        redirect_to cart_items_path
      else
        redirect_to item_path
      end
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0){|total,cart_item|total + cart_item.subtotal}
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(amount: params[:amount])
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy_all
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
