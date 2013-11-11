class CreatePhotoData < ActiveRecord::Migration
  def change
    create_table :photo_data do |t|
      t.integer :user_id
      t.integer :photo_id
      t.float :x
      t.float :y
      t.float :smile

      t.timestamps
    end
    add_index :photo_data, :user_id
    add_index :photo_data, :photo_id
  end
end
