class Inventory < ApplicationRecord
  belongs_to :user

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def market_value
    (Stock.find(self.stock_id).price * self.quantity ).round(2)
  end
end
