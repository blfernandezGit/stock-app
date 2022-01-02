require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { expect(described_class.new).to validate_inclusion_of(:transaction_type).in_array(%w[Buy Sell]) }
    it { expect(described_class.new).to validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }

    it { is_expected.to allow_value(1).for(:quantity) }
    it { is_expected.not_to allow_value(0).for(:quantity) }
    it { is_expected.not_to allow_value(-1).for(:quantity) }
  end
end