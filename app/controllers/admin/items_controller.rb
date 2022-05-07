class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def show
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image_id, :introduction, :price, :is_active)
  end

end
