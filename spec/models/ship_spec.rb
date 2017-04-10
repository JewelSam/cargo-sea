require 'rails_helper'

RSpec.describe Ship, type: :model do
  subject(:ship) { build(:ship) }

  # Association test
  it { is_expected.to have_many(:ports).through(:ports_ships) }
  it { is_expected.to have_many(:ports_ships) }

  # Validation tests
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:hold_capacity) }
  it { is_expected.to validate_numericality_of(:hold_capacity).is_greater_than(0) }
end
