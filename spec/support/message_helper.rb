# encoding: UTF-8

def add_message
  @recepient = FactoryGirl.create(:user)
  @item = FactoryGirl.create(:item, seller: @recepient)
  @sender = FactoryGirl.create(:user)
  @message = FactoryGirl.build(:message)
end
