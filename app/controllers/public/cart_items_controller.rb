class Public::CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new(cart_item_params)
    if cart_item.save
      redirect_to cart_items_path
    else
      redirect_to item_path
    end
  end

  def index
    @cart_items = current_customer.cart_items
  end

  def update
  end

  def destroy
  end

  def destroy_all
    cart_items = current_customer.cart_item
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
