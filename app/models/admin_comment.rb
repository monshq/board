class AdminComment < ActiveRecord::Base
  belongs_to :bannable, polymorphic: true
  attr_accessible :action_type, :comment
end
