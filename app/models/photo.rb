class Photo < ActiveRecord::Base
  attr_accessible :file
  belongs_to :item
end
