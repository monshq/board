require "spec_helper"

describe SendMail do
  it 'invoke mailer' do
    mail = double
    mail.should_receive(:deliver)
    BoardMailer.should_receive(:test_method).with(1,2).and_return(mail)
    SendMail.perform(:test_method, 1, 2)
  end
end
