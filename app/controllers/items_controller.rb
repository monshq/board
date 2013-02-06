class ItemsController < ApplicationController
  def index
    unless params[:keywords].empty?
      @items = Item.search params[:keywords]
    else
      @items = Item.all
    end
  end
end
