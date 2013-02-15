class User < ActiveRecord::Base
  rolify

  include Authority::Abilities
  include Authority::UserAbilities

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :state, :state_changed_at

  has_many :items, dependent: :destroy, foreign_key: 'seller_id'
  has_many :received_messages, class_name: 'Message', dependent: :destroy, foreign_key: 'recipient_id'
  has_many :sent_messages,     class_name: 'Message', dependent: :destroy, foreign_key: 'sender_id'
  has_one  :admin_comment, as: :bannable

  has_many :transactions

  self.authorizer_name = 'UsersAuthorizer'

  state_machine :state, :initial => :active do
    after_transition :on => :allow, :do => :set_state_change_date_time
    after_transition :on => :ban, :do => :set_state_change_date_time

    event :ban do
      transition :active => :banned
    end

    event :allow do
      transition :banned => :active
    end
  end

  scope :active, lambda { where("state = ?", :active) }
  scope :banned, lambda { where("state = ?", :banned) }

  def set_state_change_date_time
    @state_changed_at = Time.new

  self.authorizer_name = 'UsersAuthorizer'
  
  def pay_for_item(item)
    transaction = self.transactions.create(
      :amount => item.price,
      :item => item,
      :state => :untreated)
    Resque.enqueue(ProcessTransaction, transaction.id)
    item.reserve
    transaction.id
>>>>>>> 0b81c8c... add item buy transaction process with resque and resque-scheduler
  end
end
