class Api::V1::ShipsController < Api::CoreController

  # Get the most suitable cargo for the ship
  # /api/v1/ships/:ship_id/get_cargo
  def get_cargo
    ship = Ship.find(params[:id])
    render json: ship.most_suitable_cargo
  end

end
