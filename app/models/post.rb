class Post < ApplicationRecord
  has_many   :post_comments, dependent: :destroy
  has_many   :book_marks,    dependent: :destroy
  has_one    :camp_layout,   dependent: :destroy
  has_one    :camp_meal,     dependent: :destroy
  has_one    :campsite,      dependent: :destroy
  belongs_to :user

  has_many_attached :post_images

  def book_marked_by?(user)
    book_marks.exists?(user_id: user.id)
  end
end
