class CampLayout < ApplicationRecord
  has_many   :camp_gears, dependent: :destroy
  belongs_to :post

  has_many_attached :camp_layout_images
end
