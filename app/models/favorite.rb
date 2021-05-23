class Favorite < ApplicationRecord

  # association
  belongs_to :user
  belongs_to :post_blog

end
