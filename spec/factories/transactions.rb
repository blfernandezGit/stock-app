FactoryBot.define do
  factory :transaction do
    stock_name { "MyString" }
    quantity { 1 }
    unit_price { "9.99" }
    type { "" }
    is_fulfilled { false }
    user { nil }
  end
end
