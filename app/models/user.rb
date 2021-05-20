class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image
  attachment :profile_image
  # association
  has_many :pets, dependent: :destroy
  has_many :post_blogs, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # follow機能のassociation
  # 被フォロー側
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 与フォロー側
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォローを通じてフォロワーを参照
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォローを通じてフォロー中を参照
  has_many :followings, through: :relationships, source: :followed

  # follow機能のメソッド
  def follow(user_id)
    # create = new + save
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  validates :name, presence: true

end
