class Message < ActiveRecord::Base
  attr_accessible :text

  belongs_to :sender,    class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :item

  state_machine :read_state, :initial => :unread do
    event :read do
      transition :unread => :read
    end

    event :unread do
      transition :read => :unread
    end

    state :read do
      def unread?
        false
      end
    end

    state :unread do
      def unread?
        true
      end
    end
  end

  scope :unread, lambda { includes(:item,:sender).where('read_state = ?', :unread).order('created_at DESC', :item_id, :sender_id) }

  def post(params)
    self.assign_attributes(params, without_protection: true)
    self.save
  end

end
