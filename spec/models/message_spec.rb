# encoding: UTF-8

require 'spec_helper'

describe Message do
  describe '#post' do

    before(:each) do
      @recipient = FactoryGirl.create(:user)
      @item = FactoryGirl.create(:item, seller: @recipient)
      add_message(@item,@recipient)
    end

    it 'Добавляет сообщение от потенциального клиента к товару' do
      @message.post(sender: @sender, recipient: @recipient, item: @item)
      @item.messages.first.should eq @message
      @sender.sent_messages.first.should eq @message
      @recipient.received_messages.first.should eq @message
    end
  end

  describe 'message state_machine read_state and state' do
    before(:each) do
      @recipient = FactoryGirl.create(:user)
      @item = FactoryGirl.create(:item, seller: @recipient)
      add_message(@item,@recipient)
    end

    it 'Изменяет статус сообщения на "прочитаное/не прочитанное"' do
      @message.should be_unread
      @message.read
      @message.should_not be_unread
      @message.unread
      @message.should be_unread
    end

    it 'Изменяет статус сообщения на "архивное"' do
      @message.should be_active
      @message.archivate
      @message.should be_archived
    end
  end

end
