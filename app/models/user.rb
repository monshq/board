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

  self.authorizer_name = 'UsersAuthorizer'

  state_machine :initial => :active do
    after_transition :on => :allow, :do => :set_state_change_date_time
    after_transition :on => :ban, :do => :set_state_change_date_time

    event :ban do
      transition :active => :banned
    end

    event :allow do
      transition :banned => :active
    end

    state :banned do
      def visible?
        false
      end
    end

    state :active do
      def visible?
        true
      end
    end
  end

  scope :active, lambda { where("state = ?", :active) }
  scope :banned, lambda { where("state = ?", :banned) }

  def set_state_change_date_time
    @state_changed_at = Time.new
  end
end
