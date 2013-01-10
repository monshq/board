class Tag < ActiveRecord::Base
  has_and_belongs_to_many :items, uniq: true

  attr_accessible :name
end
