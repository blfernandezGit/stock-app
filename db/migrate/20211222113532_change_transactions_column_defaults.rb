class ChangeTransactionsColumnDefaults < ActiveRecord::Migration[6.1]
  def up
    change_column_default :transactions, :is_fulfilled, false
  end
end
