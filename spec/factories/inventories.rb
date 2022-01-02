FactoryBot.define do
  factory :inventory do
    stock
    quantity { 1 }
    user
  end
end
