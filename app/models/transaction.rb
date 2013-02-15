class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  attr_accessible :amount, :state, :item
  
  state_machine :initial => :untreated do
    before_transition :to => :accepted do |transaction|
      transaction.item.sell
    end
    
    before_transition :to => [ :canceled, :rejected ] do |transaction|
      transaction.item.publish
    end
    
    event :cancel do
      transition :untreated => :canceled
    end
    
    event :accept do
      transition :untreated => :accepted
    end
    
    event :reject do
      transition :untreated => :rejected
    end
  end
end
