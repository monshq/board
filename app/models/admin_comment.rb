class AdminComment < ActiveRecord::Base
  belongs_to :bannable
  attr_accessible :action_type, :comment
end
