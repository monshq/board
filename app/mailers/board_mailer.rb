class BoardMailer < ActionMailer::Base
  default from: "admin@board.com"

  def notify_for_a_message(options)
    options.stringify_keys!
    mail to: options["recipient_email"]
  end
end
