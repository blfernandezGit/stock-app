require 'rails_helper'

RSpec.describe Cash, type: :model do
  it { expect(described_class.new).to validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
  it { expect(described_class.new).to validate_numericality_of(:last_cash_in_amt).is_greater_than_or_equal_to(0) }

  it { is_expected.to allow_value(1).for(:balance) }
  it { is_expected.to allow_value(0).for(:balance) }
  it { is_expected.not_to allow_value(-1).for(:balance) }
  it { is_expected.to allow_value(1).for(:last_cash_in_amt) }
  it { is_expected.to allow_value(0).for(:last_cash_in_amt) }
  it { is_expected.not_to allow_value(-1).for(:last_cash_in_amt) }
end