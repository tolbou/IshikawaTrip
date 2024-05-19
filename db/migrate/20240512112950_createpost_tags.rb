class CreatepostTags < ActiveRecord::Migration[7.1]
  def change
    create_table :post_tags do |t|
      t.integer :post_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end

    # 外部キーの設定
    add_foreign_key :post_tags, :posts, column: :post_id
    add_foreign_key :post_tags, :tags, column: :tag_id
  end
end
