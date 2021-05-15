class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.integer :user_id
      t.string :name
      t.text :introduction
      t.string :image_id

      t.timestamps
    end
  end
end
