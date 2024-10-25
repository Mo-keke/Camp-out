class Campsite < ApplicationRecord
  attribute :body,    :string
  attribute :user_id, :integer

  belongs_to :post

  has_many_attached :campsite_images

  before_validation :create_post

  private

  def create_post
    if self.post_id.nil?
      post = Post.create(body: self.body, user_id: self.user_id)
      self.post_id = post.id
    end
    self
  end
end
