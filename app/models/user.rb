class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,         dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :book_marks,    dependent: :destroy
  has_many :entries,       dependent: :destroy
  has_many :messages,      dependent: :destroy
  has_many :reports,       dependent: :destroy
  has_many :inquires,      dependent: :destroy

  # フォロー中ユーザーの一覧を取得
  has_many :active_relationships,  class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :active_relationships,  source: :followed

  # フォロワーの一覧を取得
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers,  through: :passive_relationships, source: :follower

  has_one_attached :profile_image
end
