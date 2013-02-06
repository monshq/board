class Photo < ActiveRecord::Base
  attr_accessible :file, :is_main

  include Authority::Abilities

  attr_accessible :file
  belongs_to :item
  has_many :admin_comments, as: :bannable
  mount_uploader :file, PhotoUploader

  state_machine :state, :initial => :active do
    event :archivate do
      transition :active => :archived
    end
  end

  scope :active, lambda { where("state <> ?", :archived) }

end
