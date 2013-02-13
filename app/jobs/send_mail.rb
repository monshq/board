class SendMail
  @queue = :internet

  def self.perform(options)
    sleep 1.minute
  end
end
