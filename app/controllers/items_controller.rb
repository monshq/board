class ItemsController < ApplicationController
  def index
    @items = if params[:keywords].empty?
               Item.all
             else
               Item.search params[:keywords]
             end
  end
end
