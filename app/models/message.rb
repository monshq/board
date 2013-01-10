class Message < ActiveRecord::Base
  belongs_to :sender,    class_name: 'User', dependent: :destroy
  belongs_to :recipient, class_name: 'User', dependent: :destroy
  belongs_to :item,                          dependent: :destroy

  attr_accessible :text
end
