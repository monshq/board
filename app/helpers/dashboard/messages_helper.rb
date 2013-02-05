module Dashboard::MessagesHelper

  def get_items_from_messages(messages)
    items = {}
    for message in messages
      items[message.item] ||= []
      items[message.item] << message
    end
    items
  end

  def get_senders_from_item_messages(messages)
    senders = {}
    for message in messages
      senders[message.sender] ||= []
      senders[message.sender] << message
    end
    senders
  end

  def new_reply(item_id=nil, sender_id=nil, recipient_id=nil)
    reply = Message.new
    reply.item_id ||= item_id
    reply.sender_id ||= sender_id
    reply.recipient_id ||= recipient_id
    reply
  end

  def new_message_html_object_id(html_object, id_postfix)
    "new_message_#{html_object.to_s}_#{id_postfix.join('_')}"
  end

end