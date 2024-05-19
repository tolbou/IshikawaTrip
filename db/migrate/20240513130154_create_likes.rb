class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.bigint :user_id
      t.bigint :post_id

      t.timestamps
    end

    # 外部キーを設定する記述
    add_foreign_key :likes, :users, column: :user_id
    add_foreign_key :likes, :posts, column: :post_id
    add_index :likes, :user_id
    add_index :likes, :post_id
    # 重複を防ぐためのユニークインデックス
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
