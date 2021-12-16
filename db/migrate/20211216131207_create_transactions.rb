class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :stock_name
      t.integer :quantity
      t.decimal :unit_price
      t.string :type
      t.boolean :is_fulfilled
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
