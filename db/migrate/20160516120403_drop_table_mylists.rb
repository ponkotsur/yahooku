class DropTableMylists < ActiveRecord::Migration
  def change
    drop_table :mylists
  end
end
