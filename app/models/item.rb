class Item < ActiveRecord::Base
  belongs_to :seller, class_name: 'User', dependent: :destroy

  has_and_belongs_to_many :tags, uniq: true
  has_many :photos
  has_many :messages

  attr_accessible :description
  attr_accessible :contact_info

  def set_tags tags
    tags = tags.split(',') unless tags.is_a? Array
    tags.each {|t| self.tags << Tag.where(name: t).first_or_create}
  end
end
