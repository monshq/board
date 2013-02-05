class Photo < ActiveRecord::Base
  attr_accessible :file, :is_main
  belongs_to :item
  mount_uploader :file, PhotoUploader
end
