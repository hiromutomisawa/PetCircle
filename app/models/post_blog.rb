class PostBlog < ApplicationRecord

  # association
  belongs_to :user
  has_many :tag_maps, dependent: :destroy
  # throughオプションによって tag_mapsテーブルを通してtagsと関連付け
  has_many :tags, through: :tag_maps
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # favoritesテーブル内にuser_idが存在していればture,なければfalseを返すメソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
