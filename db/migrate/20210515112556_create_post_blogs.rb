class CreatePostBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :post_blogs do |t|
      t.string :image_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
