class CampMeal < ApplicationRecord
  attribute :body,    :string
  attribute :user_id, :integer

  has_many   :ingredients, dependent: :destroy, inverse_of: :camp_meal
  accepts_nested_attributes_for :ingredients, allow_destroy: true  # ネストしたモデルのレコードを同時保存するための記述
  belongs_to :post

  has_many_attached :camp_meal_images

  before_validation :create_post

  validates :name, presence: true, length: {maximum: 32}
  validates :description, presence: true, length: {maximum: 256}
  validates :recipe, presence: true, length: {maximum: 512}
  validate  :validate_camp_meal_images

  def get_camp_meal_image_variant(image, width, height)
    image.variant(resize_to_fill: [width, height]).processed
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

  def validate_camp_meal_images
    if camp_meal_images.attached?
      camp_meal_images.each do |image|
        if !image.content_type.in?(%w(image/jpeg image/png))
          errors.add(:camp_meal_images, "はJPEGまたはPNG形式でなければなりません")
        elsif image.blob.byte_size > 5.megabytes
          errors.add(:camp_meal_images, "サイズが5MBを超えるものは添付できません")
        end
      end

      if camp_meal_images.size > 4
        errors.add(:camp_meal_images, "は4枚までしか添付できません")
      end
    else
      errors.add(:camp_meal_images, "は1枚以上添付する必要があります")
    end
  end
end
