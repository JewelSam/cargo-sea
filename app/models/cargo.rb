class Cargo < ActiveRecord::Base
  belongs_to :port

  validates :title, :port_id, :date, presence: true
  validates :volume, presence: true, numericality: { greater_than: 0 }

  scope :suitable_by_volume, -> (v) { where(volume: v*0.9..v*1.1) }
  scope :suitable_and_sort_by_date, -> (date) { where('cargos.date >= ?', date).order(:date) }

  # Get the most suitable ship. The most suitable ship is:
  #
  # * suitable by hold capacity (+/-10% of the volume)
  # * closest by date arrival
  # * closest by port geolocation
  #
  # Return nil if no ships are suitable by hold capacity or date
  def most_suitable_ship
    Ship.joins(:ports)
      .suitable_by_hold_capacity(volume)
      .merge(PortsShip.suitable_and_sort_by_date(date))
      .merge(Port.closest_to(port))
      .first
  end
end
