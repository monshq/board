class SendMail
  @queue = :internet

  def self.perform(method_name, *parameters)
    BoardMailer.send(method_name, *parameters).deliver
  end
end
