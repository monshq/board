
class ItemSearch

  def initialize(search = nil)
    @search = search || Tire::Search::Search.new(Settings.elastic.index.name)
    @search.size(100) # TODO: add pagination later
  end

  def full_text_fields
    %w{
      description
      contact_info
    }
  end

  def with_state(state)
    @search.filter(:term, state: state)
    self
  end

  def with_keywords(keywords)
    fields = full_text_fields
    @search.query do
      string(keywords, fields: fields)
    end
    self
  end

  def published
    @search.filter(:term, state: 'published')
    self
  end

  def archived
    @search.filter(:term, state: 'archived')
    self
  end

  def ids
    @ids ||= @search.results.map { |item| item.id }
  end

  def raw_result
    @search.results
  end

  def entities
    @entities ||= Item.find(ids)
  end

  def self.search(options = {})
    search = new

    search.with_state(options[:state]) if options[:state].present?
    search.with_keywords(options[:keywords]) if options[:keywords].present?

    search
  end

end
