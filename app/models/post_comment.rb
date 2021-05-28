class PostComment < ApplicationRecord

  # association
  belongs_to :user
  belongs_to :post_blog

  validates :comment, presence: true
end
