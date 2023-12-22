class UserMailer < ApplicationMailer

  def daily_digest(user)
    @user = user
    I18n.with_locale(@user.language) do
      mail(to: email_address_with_name(@user.email, @user.full_name), 
          subject: t(".subject"),
          track_opens: 'true',
          message_stream: 'daily-digest')
    end
  end

end
