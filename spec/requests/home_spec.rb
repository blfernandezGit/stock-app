require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      get 'home#index'
      expect(response).to be_successful
    end
  end
end
