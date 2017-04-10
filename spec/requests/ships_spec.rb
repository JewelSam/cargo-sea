require 'rails_helper'

RSpec.describe 'Ships API', type: :request do
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

  describe 'GET /api/v1/ships/:id/get_cargo' do
    before { get "/api/v1/ships/#{ship.id}/get_cargo" }

    it 'returns the cargo' do
      expect(JSON.parse(response.body)['id']).to eq(cargo.id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
