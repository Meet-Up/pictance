class SetDefaultValueToScore < ActiveRecord::Migration
  def change
    change_column :scores, :score, :float, default: 0.0
  end
end
