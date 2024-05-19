# frozen_string_literal: true

class MonthTag < ApplicationRecord
  # PostMonthTag との多対多関連を設定（HABTM）※中間モデルを作成していないので。
  # 解説/HABTM.txt
  has_and_belongs_to_many :posts
end
