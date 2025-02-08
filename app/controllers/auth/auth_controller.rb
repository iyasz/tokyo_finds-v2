class Auth::AuthController < ApplicationController
  def loginView
    render "auth/login" 
  end
end
