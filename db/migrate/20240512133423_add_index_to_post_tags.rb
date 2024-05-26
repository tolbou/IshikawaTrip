# frozen_string_literal: true

class AddIndexToPostTags < ActiveRecord::Migration[7.1]
  def change
    add_index :post_tags, :post_id
    add_index :post_tags, :tag_id
  end
end
