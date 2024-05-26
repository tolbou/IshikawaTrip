class Post < ApplicationRecord
  # app/uploaderを読み込む
  mount_uploader :image, ImageUploader

  # Post インスタンスは常に User インスタンスに関連付けられる必要がある（外部キー）
  belongs_to :user

  # 解説/geocoded_by.txt
  geocoded_by :address
  after_validation :geocode


  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true, uniqueness: true
  validates :report, length: { maximum: 300 }
  # validates :image, length: { maximum: 3, message: 'は3枚までしかアップロードできません' }
  validates :image, presence: true

  # Tags との多対多関連を設定（HABTM）※PostTagモデルを作成していないので。
  # 解説/HABTM.txt
  has_many :post_tags
  has_many :tags, through: :post_tags

  has_many :post_month_tags
  has_many :month_tags, through: :post_month_tags
  # User と Post モデルに Like モデルを通じた関連付けを追加
  has_many :likes
  has_many :likers, through: :likes, source: :user

  private

  def geocode
    # 住所が存在し、かつその住所が変更されている場合に以下の処理を行う
    if address.present? && address_changed?
      # 解説/Geocoder.txt
      # Geocoderを使って住所から緯度と経度を検索し、最初の結果を取得する
      geo = Geocoder.search(address).first
      Rails.logger.debug "住所検索結果＝#{geo}"
      # もし検索結果が存在する場合、その結果から緯度と経度をモデルのフィールドに設定する
      if geo
        self.latitude = geo.latitude
        self.longitude = geo.longitude
      end
    end
  end
end
