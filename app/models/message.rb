class Message < ActiveRecord::Base
  attr_accessible :text

  belongs_to :sender,    class_name: 'User', dependent: :destroy
  belongs_to :recipient, class_name: 'User', dependent: :destroy
  belongs_to :item,                          dependent: :destroy
end
