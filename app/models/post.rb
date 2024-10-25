class Post < ApplicationRecord
  #attribute :review, :string
  #after_save :campsite_update

  has_many   :post_comments, dependent: :destroy
  has_many   :book_marks,    dependent: :destroy
  has_one    :camp_layout,   dependent: :destroy, inverse_of: :post
  has_one    :camp_meal,     dependent: :destroy, inverse_of: :post
  has_one    :campsite,      dependent: :destroy, inverse_of: :post
  belongs_to :user
  has_many_attached :post_images

  validates :body, presence: true, length: {maximum: 256}

  def book_marked_by?(user)
    book_marks.exists?(user_id: user.id)
  end
end
