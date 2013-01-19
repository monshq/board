class Item < ActiveRecord::Base
  attr_accessible :description, :contact_info

  belongs_to :seller, class_name: 'User'
  has_and_belongs_to_many :tags, uniq: true
  has_many :photos,   dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :contact_info, presence: true,
                           length: {minimum: 11, maximum: 255} # FIXME: Take from config

  def set_tags(tags_s)
    tags_s.split(',').each do |t|
      self.tags << Tag.where(name: t.strip).first_or_create
    end
  end
end
