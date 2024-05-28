class Post < ApplicationRecord
  # app/uploaderを読み込む
  mount_uploader :image, ImageUploader

  # Post インスタンスは常に User インスタンスに関連付けられる必要がある（外部キー）
  belongs_to :user

  # 解説/geocoded_by.txt
  geocoded_by :address
  after_validation :geocode


  validates :title, presence: { message: "を入力してください" }, length: { maximum: 255, message: "は%{count}文字以内で入力してください" }
  validates :address, presence: { message: "を入力してください" }, uniqueness: { message: "はすでに存在します" }
  validates :report, length: { maximum: 250, message: "は%{count}文字以内で入力してください" }
  validates :image, presence: { message: "を選択してください" }
  # validates :image, length: { maximum: 3, message: 'は3枚までしかアップロードできません' }
  validate :at_least_one_tag
  validate :address_must_be_in_ishikawa

  # Tags との多対多関連を設定（HABTM）※PostTagモデルを作成していないので。
  # 解説/HABTM.txt
  has_many :post_tags
  has_many :tags, through: :post_tags

  has_many :post_month_tags
  has_many :month_tags, through: :post_month_tags
  # User と Post モデルに Like モデルを通じた関連付けを追加
  has_many :likes
  has_many :likers, through: :likes, source: :user

  def image_url
    image.url
  end

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
  def at_least_one_tag
    errors.add(:base, "タグを一つ以上選択してください") if tag_ids.blank?
  end
  def address_must_be_in_ishikawa
    return if address.include?('石川県')

    errors.add(:base, '石川県の住所を入力してください')
  end
end
