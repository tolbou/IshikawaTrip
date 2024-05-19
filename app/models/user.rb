class User < ApplicationRecord
  # userインスタンスは複数のpostインスタンスを持つことができる（１対多）
  has_many :posts

  # User と Post モデルに Like モデルを通じた関連付けを追加
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  # バリデーションの定義
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :image, presence: true

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_create_by(email: user_params[:email]) do |user|
        user.name = user_params[:name]
        user.image = user_params[:image]
      end
    end

    def user_params_from_auth_hash(auth_hash)
      {
        name: auth_hash.info.name,
        email: auth_hash.info.email,
        image: auth_hash.info.image,
      }
    end
  end
end
