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

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :items, dependent: :destroy, foreign_key: 'seller_id'
  has_many :received_messages, class_name: 'Message', dependent: :destroy, foreign_key: 'recipient_id'
  has_many :sent_messages,     class_name: 'Message', dependent: :destroy, foreign_key: 'sender_id'

  self.authorizer_name = 'UsersAuthorizer'
end
