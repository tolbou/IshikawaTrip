# frozen_string_literal: true

class Tag < ApplicationRecord
  # Posts との多対多関連を設定（HABTM）※PostTagモデルを作成していないので。
  # 解説/HABTM.txt
  has_and_belongs_to_many :posts
end
