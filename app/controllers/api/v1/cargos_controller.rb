class Api::V1::CargosController < Api::CoreController

  # Get the most suitable ship for the cargo
  # /api/v1/cargos/:cargo_id/get_ship
  def get_ship
    cargo = Cargo.find(params[:id])
    render json: cargo.most_suitable_ship
  end

end
