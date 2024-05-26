class MonthTag < ApplicationRecord
  # PostMonthTag との多対多関連を設定（HABTM）※中間モデルを作成していないので。
  # 解説/HABTM.txt
  has_many :post_month_tags
  has_many :posts, through: :post_month_tags
end
