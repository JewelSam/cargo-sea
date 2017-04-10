require 'rails_helper'

RSpec.describe Ship, type: :model do
  let!(:ports) do
    Hash[ build(:ports_list).map {|country, port| [country, create(:port, port)]} ]
  end
  subject(:ship) do
    create(:ship, hold_capacity: 10000) do |ship|
      ship.ports_ships.create port: ports[:australia], date: Date.today
      ship.ports_ships.create port: ports[:japan], date: Date.today + 3.days
      ship.ports_ships.create port: ports[:ireland], date: Date.today + 7.days
    end
  end

  # Association test
  it { is_expected.to have_many(:ports).through(:ports_ships) }
  it { is_expected.to have_many(:ports_ships) }

  # Validation tests
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:hold_capacity) }
  it { is_expected.to validate_numericality_of(:hold_capacity).is_greater_than(0) }

  describe '.most_suitable_cargo' do
    let!(:small_cargo)      { create(:cargo, port: ports[:ireland], volume: 5000, date: Date.today) }
    let!(:big_today_cargo)  { create(:cargo, port: ports[:ireland], volume: 9500, date: Date.today) }
    let!(:big_late_cargo)   { create(:cargo, port: ports[:ireland], volume: 9500, date: Date.today + 6.days) }

    it 'returns only for closest date to today' do
      ship.ports_ships.first.update_attributes date: Date.today - 1.days
      expect(ship.most_suitable_cargo).to eq(big_late_cargo)
    end

    it 'returns cargo defined by volume' do
      ship.hold_capacity = 4900
      expect(ship.most_suitable_cargo).to eq(small_cargo)
    end

    it 'returns cargo defined by arrival date if volumes are equal' do
      expect(ship.most_suitable_cargo).to eq(big_today_cargo)
    end

    it 'returns cargo defined by geolocation if volumes and dates are equal' do
      japan_cargo = create(:cargo, port: ports[:japan], volume: 9500, date: Date.today)
      expect(ship.most_suitable_cargo).to eq(japan_cargo)
    end

    it 'returns nil if no suitable cargo' do
      ship.hold_capacity = 150000
      expect(ship.most_suitable_cargo).to be_nil
    end
  end
end
