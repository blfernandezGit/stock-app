require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'validations' do
        it { expect(described_class.new).to validate_inclusion_of(:role).in_array(%w[trader admin]) }
        it { expect(described_class.new).to validate_inclusion_of(:status).in_array(%w[pending accepted rejected]) }
    end
end