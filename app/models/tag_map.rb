class TagMap < ApplicationRecord

  # association
  belongs_to :post_blog
  belongs_to :tag

  # 各id が空でないこと
  validates :post_blog_id, presence: true
  validates :tag_id, presence: true

end
