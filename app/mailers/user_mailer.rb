class UserMailer < ApplicationMailer

  def daily_digest(user)
    @user = user
    mail(to: email_address_with_name(@user.email, @user.full_name), subject: 'Your Daily Teaching Schedule')
  end

end
