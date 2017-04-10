class Port < ActiveRecord::Base
  has_many :cargos, dependent: :destroy
  has_many :ports_ships, dependent: :destroy
  has_many :ships, through: :ports_ships

  validates :title, presence: true
  validates :latitude, :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
end
