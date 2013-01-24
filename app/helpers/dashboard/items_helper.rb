module Dashboard::ItemsHelper
  def item_state_select(form, item)
    form.select :state, options_from_collection_for_select(Item.state_machine.states.map(&:name), "to_s", "to_s", item.state)
  end
end
