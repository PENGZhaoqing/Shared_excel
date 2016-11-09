class ApplicationMailer < ActionMailer::Base
  # 发信人的邮箱名字,很重要
  default from: ENV['163MAIL_USERNAME']
  layout 'mailer'
end
