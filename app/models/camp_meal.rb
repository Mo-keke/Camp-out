class CampMeal < ApplicationRecord
  belongs_to :post
  
  has_many_attached :camp_meal_image
end
