# encoding: UTF-8

def add_message(item,recipient)
  @sender = FactoryGirl.create(:user)
  @message = FactoryGirl.build(:message)
  @message.post(sender: @sender, recipient: recipient, item: item)
end
