class User < ApplicationRecord
  has_secure_password

  before_create :generate_remember_token
  before_create :generate_confirmation_token

  def confirmation_token_expired?
    confirmation_sent_at && confirmation_sent_at < 1.hour.ago
  end

  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  private

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
    self.confirmation_sent_at = Time.current
  end



  validates :name, presence: { message: "tidak boleh kosong!" }
  validates :email, presence: { message: "tidak boleh kosong!" },
                    uniqueness: { message: "ini sudah digunakan!" },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "tidak valid!" }
  validates :password, presence: { message: "wajib diisi!" }, 
                       length: { minimum: 8, message: "minimal 8 karakter!" }, 
                       confirmation: { message: "tidak sesuai!" }, 
                       if: -> { google_uid.blank? }
  validates :password_confirmation, presence: { message: "wajib diisi!" }, if: -> { google_uid.blank? }



end
