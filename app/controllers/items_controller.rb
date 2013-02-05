class ItemsController < ApplicationController
  def index
    keywords = params[:keywords]
    unless keywords.nil? || keywords.empty?
      @items = Item.search keywords
    else
      @items = Item.published
    end
  end

  def show
    @item = Item.find(params[:id])
  end

end
