class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    Resque.enqueue(SendMail, {})
  end
end
