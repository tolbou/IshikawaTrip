class PostMonthTag < ApplicationRecord
    belongs_to :post
    belongs_to :month_tag, foreign_key: 'monthtag_id'
end
