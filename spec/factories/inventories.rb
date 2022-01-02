FactoryBot.define do
  factory :inventory do
    stock_id { (create :stock).id }
    quantity { 1 }
    user
  end
end
