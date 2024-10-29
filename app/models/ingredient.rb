class Ingredient < ApplicationRecord
  belongs_to :camp_meal

  validates :name, presence: true, length: {maximum: 32}
  validates :amount, presence: true, length: {maximum: 32}
end
