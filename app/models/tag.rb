class Tag < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :items, uniq: true

  before_save {|t| t.name = t.name.strip}
end
