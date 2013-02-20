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
  
  describe '#user_banned_email' do

    it 'Отсылает письмо о том что пользователь заблокирован' do
      @user = FactoryGirl.create :user
      comment = Faker::Lorem.sentence

      BoardMailer.user_banned_email(@user, comment).deliver

      message = ActionMailer::Base.deliveries.last

      message.to.should include @user.email
      message.subject.should have_text I18n.t('board_mailer.user_banned_email.user_banned_title')
      message.body.should have_text I18n.t('board_mailer.user_banned_email.user_banned_title')
      message.body.should have_text I18n.t('board_mailer.user_banned_email.user_banned_message')
      message.body.should have_text comment
    end
  end


  describe '#photo_banned_email' do

    it 'Отсылает письмо о том что картинка заблокирована' do
      @photo = FactoryGirl.create :photo
      @comment = Faker::Lorem.sentence

      BoardMailer.photo_banned_email(@photo, @comment).deliver

      message = ActionMailer::Base.deliveries.last

      message.to.should include @photo.item.seller.email
      message.subject.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_title')
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_title')
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_message')
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_link')
      message.body.should have_link item_path(@photo.item)
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_reason', reason: @comment)
      message.body.should have_text @comment
    end

  end
end
