class Photo < ActiveRecord::Base
  attr_accessible :file, :is_main

  include Authority::Abilities

  attr_accessible :file
  belongs_to :item
  mount_uploader :file, PhotoUploader
end
