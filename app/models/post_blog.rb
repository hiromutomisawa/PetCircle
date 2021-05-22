class PostBlog < ApplicationRecord

  attachment :image
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

  def save_blogs(tags)
    # tagsテーブルのnameカラム一覧を取り出す
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在持っているタグと今回保存されたタグの差をすでにあるタグとする
    old_tags = current_tags - tags
    # 今回保存されたものと現在の差を新しいタグにする
    new_tags = tags - current_tags

    # 古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end
    # 新しいタグの作成
    new_tags.each do |new_name|
      post_blog_tag = Tag.find_or_create_by(name: new_name)
      # 保存
      self.tags << post_blog_tag
    end
  end

  validates :title, presence: true
  validates :body, presence: true
end
