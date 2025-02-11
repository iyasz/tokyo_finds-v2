class UserMailer < ApplicationMailer

  default from: "akunkeduaiyas@gmail.com"

  def confirmation_email(user)
    @user = user
    puts "DEBUG: User confirmation token = #{@user.confirmation_token}"
    mail(to: @user.email, subject: "Tokyo Finds - Konfirmasi Akun Anda")
  end

end
