class PortsShip < ActiveRecord::Base
  belongs_to :port
  belongs_to :ship

  validates :ship_id, :port_id, :date, presence: true

  scope :suitable_and_sort_by_date, -> (date) { where('ports_ships.date >= ?', date).order(:date) }
end
