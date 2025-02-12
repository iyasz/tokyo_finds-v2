class Brand < ApplicationRecord
  validates :name, presence: { message: "brand tidak boleh kosong" }, 
                   uniqueness: { case_sensitive: false, message: "brand sudah digunakan" }

end
