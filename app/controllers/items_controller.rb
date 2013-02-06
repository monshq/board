class ItemsController < ApplicationController
  def index
    unless params[:keywords].empty?
      @items = Item.search params[:keywords]
    else
      @items = Item.published
    end
  end
  def show
    @item = Item.find(params[:id])
  end
end
