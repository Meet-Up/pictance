class AddDefaultToDone < ActiveRecord::Migration
  def change
   change_column :photo_data, :done, :boolean, default: false
  end
end
