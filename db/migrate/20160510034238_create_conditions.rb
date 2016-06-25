class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :title
      t.string :sql

      t.timestamps null: false
    end
  end
end