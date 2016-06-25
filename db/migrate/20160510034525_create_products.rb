class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.integer :start_price
      t.integer :current_price
      t.integer :prompt_decision_price
      t.datetime :start_date
      t.datetime :end_date
      t.string :remaining_time
      t.string :exhibitor_name
      t.integer :exhibitor_evaluation
      t.string :status
      t.integer :bit
      t.string :auction_id

      t.timestamps null: false
    end
  end
end
