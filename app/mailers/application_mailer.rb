class ApplicationMailer < ActionMailer::Base

  default from: @current_user
  layout 'mailer'
end
