class Tag < ApplicationRecord

  # association
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :post_blogs, through: :tag_maps

end
