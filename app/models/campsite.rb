class Campsite < ApplicationRecord
  attribute :body,    :string
  attribute :user_id, :integer

  belongs_to :post

  has_many_attached :campsite_images

  before_validation :create_post

  validates :name, presence: true, length: {maximum: 32}
  validates :description, presence: true, length: {maximum: 256}
  validates :address, presence: true, length: {maximum: 64}
  validates :review, presence: true
  validate  :validate_campsite_images

  def get_campsite_image_variant(image, width, height)
    image.variant(resize_to_fill: [width, height]).processed
  end

  def first_campsite_image(width, height)
    campsite_images.first&.variant(resize_to_fill: [width, height])
  end

  private

  def create_post
    if self.post_id.nil?
      post = Post.create(body: self.body, user_id: self.user_id)
      self.post_id = post.id
    end
    self
  end

  def validate_campsite_images
    if campsite_images.attached?
      campsite_images.each do |image|
        if !image.content_type.in?(%w(image/jpeg image/png))
          errors.add(:campsite_images, "はJPEGまたはPNG形式でなければなりません")
        elsif image.blob.byte_size > 5.megabytes
          errors.add(:campsite_images, "サイズが5MBを超えるものは添付できません")
        end
      end

      if campsite_images.size > 4
        errors.add(:campsite_images, "は4枚までしか添付できません")
      end
    else
      errors.add(:campsite_images, "は1枚以上添付する必要があります")
    end
  end
end
