class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    Resque.enqueue(SendMail, :notify_for_a_message, {recipient_email: message.recipient.email})
  end
end
