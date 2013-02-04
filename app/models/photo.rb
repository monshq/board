class Photo < ActiveRecord::Base

  include Authority::Abilities

  attr_accessible :file
  belongs_to :item
  mount_uploader :file, PhotoUploader
end
