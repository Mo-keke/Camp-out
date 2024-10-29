class Inquiry < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, presence: true, length: {maximum: 32}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "が無効です" }, allow_blank: true
  validates :content, presence: true, length: {maximum: 1024}
end
