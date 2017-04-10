require 'rails_helper'

RSpec.describe Cargo, type: :model do
  subject(:cargo) { build(:cargo) }

  # Association test
  it { is_expected.to belong_to(:port) }

  # Validation tests
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:port_id) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:volume) }
  it { is_expected.to validate_numericality_of(:volume).is_greater_than(0) }
end
