# frozen_string_literal: true

class CreateMonthTags < ActiveRecord::Migration[7.1]
  def change
    return if table_exists?(:month_tags)

    create_table :month_tags do |t|
      t.string :title
      t.timestamps
    end
  end
end
