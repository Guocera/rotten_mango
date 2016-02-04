class UserMailer < ApplicationMailer

  def deleted_user_email(user)
    @user = user
    @url = 'localhost:3000'
    mail(
      to: @user.email, 
      subject: "Your account was delete from Rotten Mango."
    )
  end
end
