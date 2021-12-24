class ChangeTransactionColumnName < ActiveRecord::Migration[6.1]
  def up
    remove_column :transactions, :type
    add_column :transactions, :transaction_type, :string
  end
end
