class Cargo < ActiveRecord::Base
  belongs_to :port

  validates :title, :port_id, :date, presence: true
  validates :volume, presence: true, numericality: { greater_than: 0 }
end
