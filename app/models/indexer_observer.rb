class IndexerObserver < ActiveRecord::Observer
  observe :item

  def after_update(item)
    add_to_index(item)
  end

  def after_create(item)
    add_to_index(item)
  end

  def after_archivate(item, transition)
    remove_from_index(item)
  end

  def add_to_index(item)
    IndexerObserver.elastic_index.store(item) if item.visible_for_seller?
  rescue
    Rails.logger.debug 'Cannot connect to ElasticSearch'
  end

  def remove_from_index(item)
    IndexerObserver.elastic_index.remove(item)
  rescue
    Rails.logger.debug 'Cannot connect to ElasticSearch'
  end

  protected

  def self.elastic_index
    @elastic_index ||= IndexFactory.items
  end

  def self.elastic_search
    elastic_index
    @elastic_search ||= SearchFactory.items
  end
end
