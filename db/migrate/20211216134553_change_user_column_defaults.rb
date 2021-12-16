class ChangeUserColumnDefaults < ActiveRecord::Migration[6.1]
  def up
    change_column_default :users, :role, 'trader'
    change_column_default :users, :status, 'pending'
  end
end