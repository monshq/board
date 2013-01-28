class Message < ActiveRecord::Base
  attr_accessible :text

  belongs_to :sender,    class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :item

  scope :group_by_sender, lambda { group("messages.sender_id") }

  def post(params)
    self.assign_attributes(params, without_protection: true)
    self.save
  end

end
