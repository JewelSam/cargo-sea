require 'rails_helper'

RSpec.describe Port, type: :model do
  subject(:port) { build(:port) }

  # Association test
  it { is_expected.to have_many(:ships).through(:ports_ships) }
  it { is_expected.to have_many(:ports_ships) }
  it { is_expected.to have_many(:cargos) }

  # Validation tests
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:latitude) }
  it { is_expected.to validate_presence_of(:longitude) }
  it { is_expected.to validate_numericality_of(:latitude).is_greater_than_or_equal_to(-180).is_less_than_or_equal_to(180) }
  it { is_expected.to validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180).is_less_than_or_equal_to(180) }
end
