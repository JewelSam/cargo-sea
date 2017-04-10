class Port < ActiveRecord::Base
  acts_as_mappable lat_column_name: :latitude,
                   lng_column_name: :longitude

  has_many :cargos, dependent: :destroy
  has_many :ports_ships, dependent: :destroy
  has_many :ships, through: :ports_ships

  validates :title, presence: true
  validates :latitude, :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  scope :closest_to, -> (port) { by_distance(origin: port.coords) }

  # Return array of coordinates
  def coords
    [latitude, longitude]
  end
end
