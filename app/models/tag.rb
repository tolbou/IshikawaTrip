class Tag < ApplicationRecord
  # Posts との多対多関連を設定（HABTM）※PostTagモデルを作成していないので。
  # 解説/HABTM.txt
  has_many :post_tags
  has_many :posts, through: :post_tags
end
