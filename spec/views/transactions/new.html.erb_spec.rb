require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      stock_name: "MyString",
      quantity: 1,
      unit_price: "9.99",
      type: "",
      is_fulfilled: false,
      user: nil
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input[name=?]", "transaction[stock_name]"

      assert_select "input[name=?]", "transaction[quantity]"

      assert_select "input[name=?]", "transaction[unit_price]"

      assert_select "input[name=?]", "transaction[type]"

      assert_select "input[name=?]", "transaction[is_fulfilled]"

      assert_select "input[name=?]", "transaction[user_id]"
    end
  end
end
