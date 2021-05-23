class RenameBlogIdColumnToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_column :favorites, :blog_id, :post_blog_id
  end
end
