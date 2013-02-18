require 'spec_helper'

describe MessageObserver do
  it 'when new message created enqueue gob to send email' do
    message = FactoryGirl.create :message
    MessageObserver.instance.after_create(message)
    SendMail.should have_queued(:notify_for_a_message, {recipient_email: message.recipient.email})
  end
end
