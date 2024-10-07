class Campsite < ApplicationRecord
  belongs_to :post
  
  has_many_attached :campsite_images
end
