class Photo < ActiveRecord::Base
  attr_accessible :file
  belongs_to :item
  mount_uploader :file, PhotoUploader
end
