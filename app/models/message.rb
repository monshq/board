class Message < ActiveRecord::Base

  include Authority::Abilities

  attr_accessible :text

  belongs_to :sender,    class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :item

  validates :text, presence: true, length: {in: 2..255}

  after_create :send_notification

  def send_notification
    Resque.enqueue(SendMail, {})
  end

  state_machine :state, :initial => :active do
    event :archivate do
      transition :active => :archived
    end
  end

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

  scope :unread, lambda { includes(:item,:sender).
                          where('read_state = ?', :unread).
                          order('created_at DESC', :item_id, :sender_id)
                        }
  scope :active, lambda { where("state <> ?", :archived) }

  def post(params)
    self.assign_attributes(params, without_protection: true)
    self.save
  end

  def self.mark_messages_as_read(params)
    self.update_all({read_state: :read}, {item_id: params[:item_id], sender_id: params[:recipient_id]})
  end

end
