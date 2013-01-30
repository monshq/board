class TagsController < ApplicationController
  before_filter :load_all_tags

  def load_all_tags
    @all_tags = Tag.all
  end

  def index
  end

  def show
    @selected_tags = Tag.find params[:id].split('+') # /tags/1+2
    @items = @tag.items
  end
end
