FactoryBot.define do
  factory :inventory do
    stock_name { "MyString" }
    quantity { 1 }
    user { nil }
  end
end
