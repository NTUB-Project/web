class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "user_confirmable"
    opts[:subject] = 'PartyHelper Confirmation instructions'
    opts[:from] = 'PartyHelper@admin.com'
    opts[:reply_to] = 'PartyHelper@admin.com'
    super
  end
end
