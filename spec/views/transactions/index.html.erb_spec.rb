require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        stock_name: "Stock Name",
        quantity: 2,
        unit_price: "9.99",
        type: "Type",
        is_fulfilled: false,
        user: nil
      ),
      Transaction.create!(
        stock_name: "Stock Name",
        quantity: 2,
        unit_price: "9.99",
        type: "Type",
        is_fulfilled: false,
        user: nil
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", text: "Stock Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Type".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
