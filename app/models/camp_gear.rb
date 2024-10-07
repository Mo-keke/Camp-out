class CampGear < ApplicationRecord
  belongs_to :camp_layout

  has_many_attached :camp_gear_images
end
