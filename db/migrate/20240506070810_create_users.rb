class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :image, null: false
      t.string :role, null: false
      t.timestamps
    end
  end
end
