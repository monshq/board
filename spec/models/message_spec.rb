# encoding: UTF-8

require 'spec_helper'

describe Message do
  describe '#post' do
    before(:all) do
      @recepient = FactoryGirl.create(:user)
      @item = FactoryGirl.create(:item, seller: @recepient)
      @sender = FactoryGirl.create(:user)
      @message = FactoryGirl.build(:message)
    end

    before(:each) do
    end

    it 'Добавляет сообщение от потенциального клиента к товару' do
      @message.post(sender: @sender, recipient: @recepient, item: @item)
      @item.messages[0].should eq @message
      @sender.sent_messages[0].should eq @message
      @recepient.received_messages[0].should eq @message
    end

  end
end
