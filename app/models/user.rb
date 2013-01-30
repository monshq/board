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

  has_many :items,    dependent: :destroy, foreign_key: 'seller_id'
  has_many :messages, dependent: :destroy
end
