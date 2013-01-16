class Item < ActiveRecord::Base
  attr_accessible :description, :contact_info, :tags_s

  belongs_to :seller, class_name: 'User', dependent: :destroy
  has_and_belongs_to_many :tags, uniq: true
  has_many :photos
  has_many :messages

  validates :contact_info, presence: true,
                           length: {minimum: 11} # FIXME: Take from config

  def set_tags(tags_s)
    tags_s.split(',').each do |t|
      self.tags << Tag.where(name: t).first_or_create
    end
  end

  def tags_s
    tags.collect do |t|
      t.name
    end.join ', '
  end
end
