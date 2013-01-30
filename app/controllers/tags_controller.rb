class TagsController < ApplicationController
  before_filter :load_all_tags

  def load_all_tags
    @all_tags = Tag.all
  end

  def index
  end

  def show
    @tag = Tag.find params[:id]
    @items = @tag.items
  end
end
