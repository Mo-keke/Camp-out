class CampMeal < ApplicationRecord
  has_many   :ingredients, dependent: :destroy, inverse_of: :camp_meal
    accepts_nested_attributes_for :ingredients, allow_destroy: true  # ネストしたモデルのレコードを同時保存するための記述
  belongs_to :post

  has_many_attached :camp_meal_image
end
