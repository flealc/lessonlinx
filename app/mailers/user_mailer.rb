class UserMailer < ApplicationMailer

  def daily_digest(user)
    @user = user
    mail(to: email_address_with_name(@user.email, @user.full_name), 
        subject: 'Your Daily Teaching Schedule',
        track_opens: 'true',
        message_stream: 'daily-digest')
  end

end
