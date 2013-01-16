class Item < ActiveRecord::Base
  belongs_to :seller, class_name: 'User', dependent: :destroy

  has_and_belongs_to_many :tags, uniq: true
  has_many :photos
  has_many :messages

  attr_accessible :description, :contact_info, :tags_s

  def tags_s=(tags_s)
    save

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
