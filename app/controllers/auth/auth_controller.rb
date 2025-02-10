class Auth::AuthController < ApplicationController
  layout "auth"


  def loginView
    render "auth/login"
  end

  def loginHandle
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me] == "1"

        user.update(remember_token: SecureRandom.urlsafe_base64)
        cookies.permanent.signed[:remember_token] = user.remember_token

      else
        session[:user_id] = user.id
      end

      redirect_to "/"
    else
      flash[:error] = "Email atau Password anda salah. Silahkan Coba Lagi"
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    cookies.delete(:remember_token)
    flash[:success] = "Berhasil Logout, Sampai Jumpa Lagi!"
    redirect_to login_path
  end
  

end
