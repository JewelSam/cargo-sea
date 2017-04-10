class Ship < ActiveRecord::Base
  has_many :ports_ships, dependent: :destroy
  has_many :ports, through: :ports_ships

  validates :name, presence: true
  validates :hold_capacity, presence: true, numericality: { greater_than: 0 }
end
