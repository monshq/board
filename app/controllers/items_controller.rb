class ItemsController < ApplicationController

  def index
    @items = ItemSearch.search(keywords: params[:keywords], state: 'published').entities
  end

  def show
    @item = Item.find(params[:id])
  end

end
