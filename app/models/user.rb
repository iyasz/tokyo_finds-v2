class User < ApplicationRecord
  has_secure_password

  before_create :generate_remember_token

  # validates :name, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true

  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
