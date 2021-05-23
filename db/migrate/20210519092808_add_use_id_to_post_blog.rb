class AddUseIdToPostBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :post_blogs, :user_id, :integer
  end
end
