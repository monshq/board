module Dashboard::MessagesHelper

  def get_items_from_messages(messages)
    items = {}
    for message in messages
      items[message.item] = [] unless items.include?(message.item)
      items[message.item] << message
    end
    items
  end

  def get_senders_from_item_messages(messages)
    senders = {}
    for message in messages
      senders[message.sender] = [] unless senders.include?(message.sender)
      senders[message.sender] << message
    end
    senders
  end

end