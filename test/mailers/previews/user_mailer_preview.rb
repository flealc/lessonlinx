class UserMailerPreview < ActionMailer::Preview
  def daily_digest
    UserMailer.with(user: User.find_by(first_name: "Alice")).daily_digest( User.find_by(first_name: "Alice"))
  end
end
