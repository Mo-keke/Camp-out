class CampGear < ApplicationRecord
  belongs_to :camp_layout

  has_one_attached :camp_gear_image

  def get_camp_gear_image(width, height)
    unless camp_gear_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      camp_gear_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    camp_gear_image.variant(resize_to_fill: [width, height]).processed
  end
end