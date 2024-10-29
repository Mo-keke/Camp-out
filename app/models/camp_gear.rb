class CampGear < ApplicationRecord
  belongs_to :camp_layout

  has_one_attached :camp_gear_image

  validates :name, presence: true, length: {maximum: 32}
  validates :description, presence: true, length: {maximum: 128}
  validate  :validate_camp_gear_image

  def get_camp_gear_image(width, height)
    unless camp_gear_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      camp_gear_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    camp_gear_image.variant(resize_to_fill: [width, height]).processed
  end

  private

  def validate_camp_gear_image
    if camp_gear_image.attached? && !camp_gear_image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:camp_gear_image, "はJPEGまたはPNG形式でなければなりません")
    elsif camp_gear_image.attached? && camp_gear_image.blob.byte_size > 5.megabytes
      errors.add(:camp_gear_image, "サイズが5MBを超えるものは添付できません")
    end
  end
end