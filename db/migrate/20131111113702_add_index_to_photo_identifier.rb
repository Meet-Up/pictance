class AddIndexToPhotoIdentifier < ActiveRecord::Migration
  def change
    add_index :photos, :photo_id
  end
end
