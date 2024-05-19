class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      # Userテーブルのidを外部キーとして設定
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :address
      t.string :image
      t.string :report
      # float 型を使用する際に precision や scale を指定することは通常行われません。これは、float 型が浮動小数点数を扱うため、具体的な桁数の制御ができないからです。precision と scale は、decimal 型で固定小数点数を扱う場合に指定します。
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
