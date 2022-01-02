class Transaction < ApplicationRecord
  TYPES = %w[Buy Sell].freeze
  belongs_to :user
  belongs_to :stock

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :transaction_type, inclusion: { in: TYPES }
end
