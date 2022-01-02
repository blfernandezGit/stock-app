class Cash < ApplicationRecord
  belongs_to :user

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :last_cash_in_amt, numericality: { greater_than: 0 }, :allow_nil => true
end
