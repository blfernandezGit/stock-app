class RecreateStockColumnsForRelatedTables < ActiveRecord::Migration[6.1]
  def up
    remove_column :inventories, :stock_name
    remove_column :transactions, :stock_name
    add_column :inventories, :stock_id, :bigint
    add_column :transactions, :stock_id, :bigint
  end

  def down
    add_column :inventories, :stock_name, :string
    add_column :transactions, :stock_name, :string
    remove_column :inventories, :stock_id
    remove_column :transactions, :stock_id
  end
end
