class Character < ApplicationRecord
  validates :name, presence: { message: "character tidak boleh kosong" },
                   uniqueness: { case_sensitive: false, message: "character sudah digunakan" }
end
