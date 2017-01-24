class ChangeColumnNameCompToCmp < ActiveRecord::Migration[5.0]
  def change
  	rename_column :passing_statistics, :comp, :cmp
  end
end
