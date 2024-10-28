class CampLayout < ApplicationRecord
  attribute :body,    :string
  attribute :user_id, :integer

  has_many   :camp_gears, dependent: :destroy, inverse_of: :camp_layout
  accepts_nested_attributes_for :camp_gears, reject_if: :all_blank  # ネストしたモデルのレコードを同時保存するための記述、全て空の場合は保存を拒否
  belongs_to :post

  has_many_attached :camp_layout_images

  before_validation :create_post

  def get_camp_layout_images(width, height)
    camp_layout_images.map do |image|
      image.variant(resize_to_fill: [width, height]).processed
    end
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
end
