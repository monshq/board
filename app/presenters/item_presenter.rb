class ItemPresenter < Keynote::Presenter
  presents :item

  def tags
    item.tags.pluck(:name).join ', '
  end
end
