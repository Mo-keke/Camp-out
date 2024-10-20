class CampLayout < ApplicationRecord
  has_many   :camp_gears, dependent: :destroy, inverse_of: :camp_layout
    accepts_nested_attributes_for :camp_gears, reject_if: :all_blank  # ネストしたモデルのレコードを同時保存するための記述、全て空の場合は保存を拒否
  belongs_to :post

  has_many_attached :camp_layout_images
end
