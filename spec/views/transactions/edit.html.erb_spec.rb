require 'rails_helper'

RSpec.describe "transactions/edit", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      stock_name: "MyString",
      quantity: 1,
      unit_price: "9.99",
      type: "",
      is_fulfilled: false,
      user: nil
    ))
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do

      assert_select "input[name=?]", "transaction[stock_name]"

      assert_select "input[name=?]", "transaction[quantity]"

      assert_select "input[name=?]", "transaction[unit_price]"

      assert_select "input[name=?]", "transaction[type]"

      assert_select "input[name=?]", "transaction[is_fulfilled]"

      assert_select "input[name=?]", "transaction[user_id]"
    end
  end
end
