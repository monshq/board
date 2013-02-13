class ItemsController < ApplicationController

  def index
    keywords = params[:keywords]
    unless keywords.nil? || keywords.empty?
      @items = SearchFactory.items.search(q: keywords).items
    else
      @items = Item.published
    end
  end

  def show
    @item = Item.find(params[:id])
  end
  
end
