require 'rails_helper'

RSpec.describe Cargo, type: :model do
  let!(:ports) do
    Hash[ build(:ports_list).map {|country, port| [country, create(:port, port)]} ]
  end
  subject(:cargo) { create(:cargo, port: ports[:ireland], date: Date.today) }

  # Association test
  it { is_expected.to belong_to(:port) }

  # Validation tests
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:port_id) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:volume) }
  it { is_expected.to validate_numericality_of(:volume).is_greater_than(0) }

  describe '.most_suitable_ship' do
    let!(:big_ship1) do
      create(:ship, hold_capacity: 10000) do |ship|
        ship.ports_ships.create port: ports[:ireland], date: Date.today + 2.days
        ship.ports_ships.create port: ports[:japan], date: Date.today + 5.days
      end
    end

    let!(:small_ship) do
      create(:ship, hold_capacity: 5000) do |ship|
        ship.ports_ships.create port: ports[:ireland], date: Date.today
        ship.ports_ships.create port: ports[:japan], date: Date.today + 3.days
        ship.ports_ships.create port: ports[:australia], date: Date.today + 7.days
      end
    end

    let!(:big_ship2) do
      create(:ship, hold_capacity: 10000) do |ship|
        ship.ports_ships.create port: ports[:ireland], date: Date.today + 5.days
        ship.ports_ships.create port: ports[:japan], date: Date.today + 7.days
      end
    end

    context 'when ship is uniquely defined by hold capacity' do
      it 'returns ship with 10000 hold capacity if volume is 9500' do
        cargo.volume = 9500
        expect(cargo.most_suitable_ship).to eq(big_ship1)
      end

      it 'returns ship with 5000 hold capacity if volume is 4900' do
        cargo.volume = 4900
        expect(cargo.most_suitable_ship).to eq(small_ship)
      end
    end

    context 'when ship is uniquely defined by arrival date and hold capacity is equal' do
      it 'returns ship with today\'s arrival date if date of cargo is today' do
        cargo.volume, cargo.date = 9500, Date.today
        expect(cargo.most_suitable_ship).to eq(big_ship1)
      end

      it 'returns ship with 7 days arrival date if cargo will arrive in 6 days' do
        cargo.volume, cargo.date = 9500, Date.today + 6.days
        expect(cargo.most_suitable_ship).to eq(big_ship2)
      end
    end

    context 'when ship is uniquely defined by geolocation and hold capacity and date are equal' do
      subject(:cargo) { create(:cargo, port: ports[:australia], volume: 9500, date: Date.today + 5.days) }

      it 'returns ship from Japan if cargo\'s port is in Australia' do
        expect(cargo.most_suitable_ship).to eq(big_ship1)
      end

      it 'returns ship from Ireland if cargo\'s port is in Ireland' do
        cargo.port = ports[:ireland]
        expect(cargo.most_suitable_ship).to eq(big_ship2)
      end
    end

    it 'returns nil if no suitable ship' do
      cargo.volume = 150000
      expect(cargo.most_suitable_ship).to be_nil
    end
  end
end
