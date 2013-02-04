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

  def new_reply(params)
    reply = Message.new
    params.each do |attr, value|
      reply.send(attr.to_s+'=', value)
    end
    reply
  end

  def new_message_html_object_id(html_object, id_postfix)
    "new_message_"+html_object.to_s+"_"+id_postfix.join('_')
  end

end