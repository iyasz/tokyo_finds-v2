class User < ApplicationRecord
  has_secure_password

  before_create :generate_remember_token

  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  # validates :name, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true
  
  validates :name, presence: { message: "tidak boleh kosong!" }
  validates :email, presence: { message: "tidak boleh kosong!" },
                    uniqueness: { message: "ini sudah digunakan!" },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "tidak valid!" }
  validates :password, presence: { message: "wajib diisi!" }, 
                       length: { minimum: 8, message: "minimal 8 karakter!" }, 
                       confirmation: { message: "tidak sesuai!" }
  validates :password_confirmation, presence: { message: "wajib diisi!" }, on: :create



end
