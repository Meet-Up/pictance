class AddDoneToPhotoData < ActiveRecord::Migration
  def change
    add_column :photo_data, :done, :boolean
  end
end
