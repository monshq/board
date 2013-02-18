require "spec_helper"

describe BoardMailer do
  describe "notify_for_a_message" do
    it "send correct message" do
      mail = BoardMailer.notify_for_a_message(recipient_email: "a@a.ru")
      mail.to.should eq ["a@a.ru"]
      mail.from.should eq ["admin@board.com"]
      mail.body.encoded.should have_text I18n.t('board_mailer.notify_for_a_message.text')
      mail.body.should include dashboard_messages_path(:only_path => false)
      mail.subject.should eq I18n.t('board_mailer.notify_for_a_message.subject')
    end
  end
end
