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
    user_params = params.except(:authenticity_token).permit(:name, :email, :password, :password_confirmation)

    user = User.new(user_params)
    user.roles = 2
    user.confirmation_sent_at = Time.current

    if user.save
      UserMailer.confirmation_email(user).deliver_now
      flash.now[:success] = "Akun berhasil dibuat! Silakan cek email untuk verifikasi."
      render :"/auth/login"
    else
      flash.now[:error] = user.errors.full_messages.first
      render :"auth/register", status: :unprocessable_entity
    end
  end

  def confirm_email
    user = User.find_by(confirmation_token: params[:token])

    if user.nil?
      flash[:error] = "Token tidak valid atau sudah digunakan!"
      return redirect_to "/login"
    end

    user.update(confirmed_at: Time.current, confirmation_token: nil)
    flash[:success] = "Akun berhasil diverifikasi! Silakan login."
    redirect_to "/login"
  end

  def resend_confirmation
    user = User.find_by(confirmation_token: params[:token])

    # Jika user tidak ditemukan
    if user.nil?
      flash[:error] = "Token tidak valid atau sudah digunakan!"
      return redirect_to "/login"
    end

    # Cek apakah token masih berlaku (misal: 1 jam)
    if user.confirmation_sent_at.present? && user.confirmation_sent_at > 1.hour.ago
      flash[:info] = "Token masih berlaku. Silakan gunakan link yang telah dikirim."
      return redirect_to confirm_email_path(token: user.confirmation_token)
    end

    # Token expired → Generate token baru dan kirim ulang email
    user.update(confirmation_token: SecureRandom.urlsafe_base64, confirmation_sent_at: Time.current)
    UserMailer.confirmation_email(user).deliver_now

    flash[:success] = "Token baru telah dikirim ke email Anda. Silakan cek email Anda."
    redirect_to "/login"
  end



  def google_auth
    auth = request.env["omniauth.auth"]

    user = User.find_or_initialize_by(google_uid: auth.uid) do |u|
      u.email = auth.info.email
      u.name = auth.info.name
      u.google_uid = auth.uid
      u.roles = 2
    end

    if user.new_record?
      if user.save
      else
        flash.now[:error] = user.errors.full_messages.first
        redirect_to login_path and return
      end
    end

    session[:user_id] = user.id
    redirect_to root_path
  end


  def logout
    session[:user_id] = nil
    cookies.delete(:remember_token)
    redirect_to login_path
  end
  

end
