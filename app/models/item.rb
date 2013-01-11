class Item < ActiveRecord::Base
  belongs_to :seller, class_name: 'User', dependent: :destroy

  has_and_belongs_to_many :tags, uniq: true
  has_many :photos
  has_many :messages

  attr_accessible :description

  def set_tags *tags
    tags.flatten.each do |tag|
      tag.split(',').each do |tag|
        tag.strip!
        self.tags.create name: tag unless Tag.find_by_name tag
      end
    end
  end
end
