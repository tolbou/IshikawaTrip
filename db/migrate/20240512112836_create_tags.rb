class CreateTags < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:tags)
      create_table :tags do |t|
        t.string :title
        t.timestamps
      end
    end
  end
end
