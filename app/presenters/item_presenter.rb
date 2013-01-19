class ItemPresenter < Keynote::Presenter
  presents :item

  def tags
    item.tags.collect do |tag|
      tag.name
    end.join ', '
  end
end
