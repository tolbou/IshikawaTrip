# frozen_string_literal: true

class Post < ApplicationRecord
  # Post インスタンスは常に User インスタンスに関連付けられる必要がある（外部キー）
  belongs_to :user

  # 解説/geocoded_by.txt
  geocoded_by :address
  after_validation :geocode

  # アドレスが必ず入力されるようにバリデーションを設定
  validates :address, presence: true

  # Tags との多対多関連を設定（HABTM）※PostTagモデルを作成していないので。
  # 解説/HABTM.txt
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :month_tags

  # User と Post モデルに Like モデルを通じた関連付けを追加
  has_many :likes
  has_many :likers, through: :likes, source: :user
end
