class UserMailer < ApplicationMailer

  default from: "no-reply@yourdomain.com"

  def confirmation_email(user)
    @user = user
    @token = @user.confirmation_token
    mail(to: @user.email, subject: "Konfirmasi Akun Anda")
  end

end
