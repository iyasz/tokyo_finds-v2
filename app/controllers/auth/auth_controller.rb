class Auth::AuthController < ApplicationController
  layout "auth"

  def loginView
    render "auth/login"
  end

  def loginHandle
    login_params = params.permit(:email, :password, :remember_me)

    if login_params[:email].blank? || login_params[:password].blank?
      flash.now[:error] = "Email dan Password harus diisi!"
      return render :"auth/login", status: :unprocessable_entity
    end

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
      flash.now[:error] = "Email atau Password anda salah!"
      render :"auth/login", status: :unprocessable_entity
    end
  end

  def registerView
    render "auth/register"
  end

  def registerHandle
    user_params = params.permit(:name, :email, :password, :password_confirmation)

    user = User.new(user_params)
    user.roles = 2

    if user.save
      session[:user_id] = user.id
      redirect_to "/"
    else
      flash.now[:error] = user.errors.full_messages.first
      render :"auth/register", status: :unprocessable_entity
    end
  end


  def logout
    session[:user_id] = nil
    cookies.delete(:remember_token)
    redirect_to login_path
  end
  

end
