class Category < ApplicationRecord
  has_one_attached :before_cover
  has_one_attached :after_cover

  validate :validate_image_presence, on: :create
  validate :validate_image_format
  validate :validate_image_size

  validates :name, presence: { message: "category tidak boleh kosong" }, 
                   uniqueness: { case_sensitive: false, message: "category sudah digunakan" }

  private

  def validate_image_presence
    errors.add(:before_cover, "wajib diunggah!") unless before_cover.attached?
    errors.add(:after_cover, "wajib diunggah!") unless after_cover.attached?
  end

  def validate_image_format
    allowed_types = ["image/png", "image/jpeg", "image/webp"]

    if before_cover.attached? && !allowed_types.include?(before_cover.content_type)
      errors.add(:before_cover, "format tidak didukung! Gunakan PNG, JPG, atau WebP.")
    end
    if after_cover.attached? && !allowed_types.include?(after_cover.content_type)
      errors.add(:after_cover, "format tidak didukung! Gunakan PNG, JPG, atau WebP.")
    end 
  end

  def validate_image_size
    max_size = 5.megabytes

    if before_cover.attached? && before_cover.byte_size > max_size
      errors.add(:before_cover, "ukuran terlalu besar! Maksimum 5MB.")
    end
    if after_cover.attached? && after_cover.byte_size > max_size
      errors.add(:after_cover, "ukuran terlalu besar! Maksimum 5MB.")
    end
  end
end
