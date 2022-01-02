FactoryBot.define do
  factory :transaction do
    stock_id { (create :stock).id }
    quantity { 1 }
    unit_price { 9.99 }
    transaction_type { "Buy" }
    is_fulfilled { false }
    user
  end
end