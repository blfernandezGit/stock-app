require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'validations' do
    it { expect(described_class.new).to validate_uniqueness_of(:code) }
  end
end
