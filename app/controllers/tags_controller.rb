class TagsController < ApplicationController
  before_filter :load_all_tags

  def index
    @selected_tags = []
    compose_linked_ids
  end

  def show
    @selected_tags = Tag.find params[:id].split('+') # /tags/1+2
    @tagged_items = Item.tagged_with @selected_tags
    compose_linked_ids
  end

  private

  def load_all_tags
    @all_tags = Tag.all
  end

  def compose_linked_ids
    @linked_ids = {}

    @all_tags.each do |tag|
      linked_tags = if @selected_tags.include? tag
                      @selected_tags - [tag]
                    else
                      @selected_tags + [tag]
                    end
      linked_tag_ids = linked_tags.collect { |t| t.id }
      @linked_ids[tag.id] = linked_tag_ids.join('+')
    end
  end
end
