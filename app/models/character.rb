class Character < ApplicationRecord
  validates :name, presence: { message: "series tidak boleh kosong" },
                   uniqueness: { case_sensitive: false, message: "series sudah digunakan" }
end
