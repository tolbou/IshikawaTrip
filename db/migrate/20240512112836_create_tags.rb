# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.1]
  def change
    return if table_exists?(:tags)

    create_table :tags do |t|
      t.string :title
      t.timestamps
    end
  end
end
