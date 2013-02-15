class ItemsController < ApplicationController

  def index
    keywords = params[:keywords]
    unless keywords.blank?
      @items = ElasticSearch::Factories::SearchFactory.items.search(q: keywords)
    else
      @items = Item.published
    end
  end

  def show
    @item = Item.find(params[:id])
  end
  
end
