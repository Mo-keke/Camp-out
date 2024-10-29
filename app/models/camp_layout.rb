class CampLayout < ApplicationRecord
  attribute :body,    :string
  attribute :user_id, :integer

  has_many   :camp_gears, dependent: :destroy, inverse_of: :camp_layout
  accepts_nested_attributes_for :camp_gears, reject_if: :all_blank  # ネストしたモデルのレコードを同時保存するための記述、全て空の場合は保存を拒否
  belongs_to :post

  has_many_attached :camp_layout_images

  before_validation :create_post

  validates :title, presence: true, length: {maximum: 32}
  validates :description, presence: true, length: {maximum: 256}
  validate  :validate_camp_layout_images

  def get_camp_layout_image_variant(image, width, height)
    image.variant(resize_to_fill: [width, height]).processed
  end

  def first_camp_layout_image(width, height)
    camp_layout_images.first&.variant(resize_to_fill: [width, height])
  end

  private

  def create_post
    if self.post_id.nil?
      post = Post.create(body: self.body, user_id: self.user_id)
      self.post_id = post.id
    end
    self
  end

  def validate_camp_layout_images
    if camp_layout_images.attached?
      camp_layout_images.each do |image|
        if !image.content_type.in?(%w(image/jpeg image/png))
          errors.add(:camp_layout_images, "はJPEGまたはPNG形式でなければなりません")
        elsif image.blob.byte_size > 5.megabytes
          errors.add(:camp_layout_images, "サイズが5MBを超えるものは添付できません")
        end
      end

      if camp_layout_images.size > 4
        errors.add(:camp_layout_images, "は4枚までしか添付できません")
      end
    else
      errors.add(:camp_layout_images, "は1枚以上添付する必要があります")
    end
  end
end