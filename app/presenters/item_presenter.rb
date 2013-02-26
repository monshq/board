class ItemPresenter < Keynote::Presenter
  presents :item

  def tags
    item.tags.map { |t| t.name }.join ', '
  end
  
  def price
    item.price.blank? ? '' : sprintf("%#0.2f USD", item.price)
  end
end
