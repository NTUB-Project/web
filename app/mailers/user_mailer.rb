class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "user_confirmable"
    opts[:subject] = 'PartyHelper Confirmation instructions'
    opts[:from] = 'partyhelper.ntub@gmail.com'
    opts[:reply_to] = 'partyhelper.ntub@gmail.com'
    super
  end
end
