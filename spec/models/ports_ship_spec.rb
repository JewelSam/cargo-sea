require 'rails_helper'

RSpec.describe PortsShip, type: :model do
  subject(:ports_ship) { build(:ports_ship) }

  # Association test
  it { is_expected.to belong_to(:port) }
  it { is_expected.to belong_to(:ship) }

  # Validation tests
  it { is_expected.to validate_presence_of(:port_id) }
  it { is_expected.to validate_presence_of(:ship_id) }
  it { is_expected.to validate_presence_of(:date) }
end
