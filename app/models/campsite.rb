class Campsite < ApplicationRecord
  attribute :body,    :string
  attribute :user_id, :integer

  belongs_to :post

  has_many_attached :campsite_images

  before_validation :create_post

  def get_campsite_images(width, height)
    campsite_images.map do |image|
      image.variant(resize_to_fill: [width, height]).processed
    end
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
end
