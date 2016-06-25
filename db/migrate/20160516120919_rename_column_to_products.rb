class RenameColumnToProducts < ActiveRecord::Migration
  def change
    rename_column :products, :kid , :keyword_id
  end
end
