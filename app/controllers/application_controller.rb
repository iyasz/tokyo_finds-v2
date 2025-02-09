class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user

  def authenticate_user
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    elsif cookies.signed[:remember_token]
      @current_user = User.find_by(remember_token: cookies.signed[:remember_token])
      session[:user_id] = @current_user.id if @current_user
    end
  end
  
end
