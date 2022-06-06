class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: :true)
    @genres = Genre.all
    if params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      @all_items = @genre.items.where(is_active: :true)
    else
      @all_items = Item.where(is_active: :true).includes(:genre)
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
end
