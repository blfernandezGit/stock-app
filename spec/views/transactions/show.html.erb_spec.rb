require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      stock_name: "Stock Name",
      quantity: 2,
      unit_price: "9.99",
      type: "Type",
      is_fulfilled: false,
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Stock Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
