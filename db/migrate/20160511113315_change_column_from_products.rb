class ChangeColumnFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :remaining_time, :string
    add_column :products, :remaining_time, :integer
    add_column :products, :remaining_time_unit, :string
  end
end
