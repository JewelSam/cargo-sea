require 'rails_helper'

RSpec.describe 'Cargos API', type: :request do
  let!(:ports) do
    Hash[ build(:ports_list).map {|country, port| [country, create(:port, port)]} ]
  end
  let!(:ship) do
    create(:ship, hold_capacity: 10000) do |ship|
      ship.ports_ships.create port: ports[:ireland], date: Date.today
      ship.ports_ships.create port: ports[:japan], date: Date.today + 5.days
    end
  end
  let!(:cargo) { create(:cargo, port: ports[:ireland], date: Date.today, volume: 9500) }

  describe 'GET /api/v1/cargos/:id/get_ship' do
    before { get "/api/v1/cargos/#{cargo.id}/get_ship" }

    it 'returns the ship' do
      expect(JSON.parse(response.body)['id']).to eq(ship.id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
