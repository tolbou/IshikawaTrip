class Like < ApplicationRecord
    # Likeモデルファイルがあるので、HABTMは使用しない。
    # 多対多の記載
    belongs_to :user
    belongs_to :post
end
