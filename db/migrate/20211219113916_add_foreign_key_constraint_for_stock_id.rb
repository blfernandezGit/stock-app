class AddForeignKeyConstraintForStockId < ActiveRecord::Migration[6.1]
    def up
      add_foreign_key :inventories, :stocks, column: :stock_id
      add_foreign_key :transactions, :stocks, column: :stock_id
    end
end
