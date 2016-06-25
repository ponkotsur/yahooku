class RenameColumnToKeywords < ActiveRecord::Migration
  def change
    rename_column :keywords, :mylist_id, :group_id
  end
end
