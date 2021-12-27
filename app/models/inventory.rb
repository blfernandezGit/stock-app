class Inventory < ApplicationRecord
  belongs_to :user

  def market_value
    (Stock.find(self.stock_id).price * self.quantity ).round(2)
  end
end
