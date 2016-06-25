class ChangeColumnFromCondition < ActiveRecord::Migration
  def up
    remove_column :conditions, :created_at , :timestamp
    remove_column :conditions, :updated_at , :timestamp
  end
end
