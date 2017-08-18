class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_book.subject
  #
  def sendmail_book(book)
    @book = book

    mail to: "wk19841024@gmail.com",
      subject: "【WKbook】トピックが投稿されました"
  end
end
