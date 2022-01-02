require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:each) do
    sign_in create(:user, :admin)
  end

  let(:valid_attributes) {
    FactoryBot.attributes_for(:user)
  }

  it "renders a successful response" do
    create :user
    get client_list_url
    expect(response).to be_successful
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_client_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post create_client_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to inventories" do
        post create_client_url, params: { user: valid_attributes }
        expect(response).to redirect_to(client_url(User.last))
      end
    end

    # context "with invalid parameters" do
    #   it "does not create a new Transaction" do
    #     expect {
    #       post transactions_url, params: { transaction: invalid_attributes }
    #     }.to change(Transaction, :count).by(0)
    #   end

    #   it "renders a successful response (i.e. to display the 'new' template)" do
    #     post transactions_url, params: { transaction: invalid_attributes }
    #     expect(response).to redirect_to(new_transaction_url(:transaction_type => invalid_attributes[:transaction_type], :stock_id => invalid_attributes[:stock_id], :price => invalid_attributes[:unit_price]))
    #   end
    # end
  end
end