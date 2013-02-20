class IndexerObserver < ActiveRecord::Observer
  observe :item

  def after_update(item)
    add_to_index(item)
  end

  def after_create(item)
    add_to_index(item)
  end

  def after_destroy(item)
    remove_from_index(item)
  end

  def add_to_index(item)
    elastic_index.store(item)
  rescue
    Rails.logger.debug 'Cannot connect to ElasticSearch'
  end

  def remove_from_index(item)
    elastic_index.remove(item)
  rescue
    Rails.logger.debug 'Cannot connect to ElasticSearch'
  end

  private

  def elastic_index
    @index ||= ElasticSearch::Factories::IndexFactory.items
  end

end
