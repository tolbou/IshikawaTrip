class CreatePostMonthTags < ActiveRecord::Migration[7.1]
  def change
    create_table :post_month_tags do |t|
      t.bigint :monthtag_id, null: false
      t.bigint :post_id, null: false

      t.timestamps
    end

    add_foreign_key :post_month_tags, :posts, column: :post_id
    add_foreign_key :post_month_tags, :month_tags, column: :monthtag_id
    add_index :post_month_tags, :post_id
    add_index :post_month_tags, :monthtag_id
  end
end
