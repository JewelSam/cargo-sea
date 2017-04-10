class PortsShip < ActiveRecord::Base
  belongs_to :port
  belongs_to :ship

  validates :ship_id, :port_id, :date, presence: true
end
