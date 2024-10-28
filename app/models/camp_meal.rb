class CampMeal < ApplicationRecord
  attribute :body,    :string
  attribute :user_id, :integer

  has_many   :ingredients, dependent: :destroy, inverse_of: :camp_meal
  accepts_nested_attributes_for :ingredients, allow_destroy: true  # ネストしたモデルのレコードを同時保存するための記述
  belongs_to :post

  has_many_attached :camp_meal_images

  before_validation :create_post

  def get_camp_meal_images(width, height)
    camp_meal_images.map do |image|
      image.variant(resize_to_fill: [width, height]).processed
    end
  end

  def first_camp_meal_image(width, height)
    camp_meal_images.first&.variant(resize_to_fill: [width, height])
  end

  private

  def create_post
    if self.post_id.nil?
      post = Post.create(body: self.body, user_id: self.user_id)
      self.post_id = post.id
    end
    self
  end
end
