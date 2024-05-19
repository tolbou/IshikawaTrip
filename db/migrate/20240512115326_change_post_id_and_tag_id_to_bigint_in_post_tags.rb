class ChangePostIdAndTagIdToBigintInPostTags < ActiveRecord::Migration[6.0]
  def up
    change_column :post_tags, :post_id, :bigint, using: 'post_id::bigint'
    change_column :post_tags, :tag_id, :bigint, using: 'tag_id::bigint'
  end

  def down
    change_column :post_tags, :post_id, :integer, using: 'post_id::integer'
    change_column :post_tags, :tag_id, :integer, using: 'tag_id::integer'
  end
end
