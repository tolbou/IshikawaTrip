class CreateMonthTags < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:month_tags)
      create_table :month_tags do |t|
        t.string :title
        t.timestamps
      end
    end
  end
end
