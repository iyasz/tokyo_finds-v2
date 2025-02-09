class Auth::AuthController < ApplicationController
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
      flash[:alert] = "Email atau Password anda salah. Silahkan Coba Lagi"
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    cookies.delete(:remember_token)
    redirect_to login_path, notice: "Logged out successfully!"
  end
  

end
