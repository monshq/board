class Tag < ActiveRecord::Base

  include Authority::Abilities

  attr_accessible :name

  has_and_belongs_to_many :items, uniq: true

  def name=(name)
    write_attribute :name, name.strip
  end
end
