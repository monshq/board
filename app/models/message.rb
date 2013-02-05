class Message < ActiveRecord::Base

  include Authority::Abilities

  attr_accessible :text

  belongs_to :sender,    class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :item
end
