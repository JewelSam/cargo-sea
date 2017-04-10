class Ship < ActiveRecord::Base
  has_many :ports_ships, dependent: :destroy
  has_many :ports, through: :ports_ships

  validates :name, presence: true
  validates :hold_capacity, presence: true, numericality: { greater_than: 0 }

  scope :suitable_by_hold_capacity, -> (v) { where(hold_capacity: v*0.9..v*1.1) }

  # Get the most suitable cargo for the next port. The most suitable cargo is:
  #
  # * suitable by volume (+/-10% of the hold capacity)
  # * closest by date arrival
  # * closest by port geolocation
  #
  # Return nil if no cargo are suitable by volume or date
  def most_suitable_cargo
    arrival_point = ports_ships.suitable_and_sort_by_date(Date.today).first

    Cargo.joins(:port)
      .suitable_by_volume(hold_capacity)
      .suitable_and_sort_by_date(arrival_point.date)
      .merge(Port.closest_to(arrival_point.port))
      .first
  end
end
