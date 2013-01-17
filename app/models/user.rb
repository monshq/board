class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :items,    dependent: :destroy
  has_many :messages, dependent: :destroy
end
