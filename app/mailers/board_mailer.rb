class BoardMailer < ActionMailer::Base
  default from: "admin@board.com"

  def notify_for_a_message(options)
    options.stringify_keys!
    mail to: options["recipient_email"]
  end

  def user_banned_email(user, comment)
    @params = {comment: comment}
    mail(:to => user.email, :subject => I18n.t('board_mailer.user_banned_email.user_banned_title'))
  end

  def photo_banned_email(photo, comment)
    @params = {item: photo.item, photo_id: photo.id, reason: comment}
    mail(:to => photo.item.seller.email, :subject => I18n.t('board_mailer.photo_banned_email.photo_banned_title'))
  end
end
