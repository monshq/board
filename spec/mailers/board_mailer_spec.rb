require "spec_helper"

describe BoardMailer do
  describe "notify_for_a_message" do
    it "send correct message" do
      mail = BoardMailer.notify_for_a_message(recipient_email: "a@a.ru")
      mail.to.should eq ["a@a.ru"]
      mail.from.should eq ["admin@board.com"]
      mail.body.encoded.should have_text "new message"
      mail.body.should include dashboard_messages_path(:only_path => false)
    end
  end
end
