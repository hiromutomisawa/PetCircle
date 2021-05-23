class RenameBlogIdColumnToPostComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :post_comments, :blog_id, :post_blog_id
  end
end
