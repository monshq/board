class ItemPresenter < Keynote::Presenter
  presents :item

  def tags
    item.tags.map { |t| t.name }.join ', '
  end
end
