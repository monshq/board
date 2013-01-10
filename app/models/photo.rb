class Photo < ActiveRecord::Base
  belongs_to :item, dependent: :destroy
end
