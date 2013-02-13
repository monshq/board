require 'spec_helper'

describe MessageObserver do
  it 'when new message created enqueue gob to send email' do
    MessageObserver.instance.after_create(FactoryGirl.create :message)
    SendMail.should have_queued({})
  end
end
