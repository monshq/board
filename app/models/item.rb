class Item < ActiveRecord::Base
  belongs_to :seller, class_name: 'User', dependent: :destroy

  has_and_belongs_to_many :tags, uniq: true
  has_many :photos
  has_many :messages

  attr_accessible :description
end
