# encoding: UTF-8

require 'spec_helper'

describe Message do
  describe '#post' do
    before(:all) do
    end

    before(:each) do
      add_message
    end

    it 'Добавляет сообщение от потенциального клиента к товару' do
      @message.post(sender: @sender, recipient: @recepient, item: @item)
      @item.messages[0].should eq @message
      @sender.sent_messages[0].should eq @message
      @recepient.received_messages[0].should eq @message
    end
  end

  describe 'message state_machine read_state' do
    before(:each) do
      add_message
    end

    it 'Изменяет статус сообщения на "прочитаное/не прочитанное"' do
      @message.should be_unread
      @message.read
      @message.should_not be_unread
      @message.unread
      @message.should be_unread
    end
  end

end
