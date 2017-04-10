# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Port.create [
  {
    "title" => "Dingle Harbour",
    "latitude" => 52.13333333,
    "longitude" => -10.26666667
  },
  {
    "title" => "Hirao",
    "latitude" => 33.9,
    "longitude" => 132.05
  },
  {
    "title" => "Humbug Point Wharf",
    "latitude" => -12.66666667,
    "longitude" => 141.8666667
  },
  {
    "title" => "Benghazi",
    "latitude" => 32.1166,
    "longitude" => 20.0833
  },
  {
    "title" => "Seaham",
    "latitude" => 54.8333,
    "longitude" => -1.3166
  },
  {
    "title" => "Blue Beach Harbour",
    "latitude" => 48.78333333,
    "longitude" => -58.78333333
  },
  {
    "title" => "Skamania County",
    "latitude" => 45.68333333,
    "longitude" => -121.8833333
  },
  {
    "title" => "Puerto de Calpe",
    "latitude" => 0.0,
    "longitude" => -0.3333333333
  }
] unless Port.exists?

Ship.create [
  {
    name: "The Santa Maria",
    hold_capacity: 5000
  },
  {
    name: "Constitution",
    hold_capacity: 10000
  },
  {
    name: "Victory",
    hold_capacity: 7000
  },
  {
    name: "Titanic",
    hold_capacity: 15000
  }
] unless Ship.exists?

(Date.today .. (Date.today + 7.days)).each do |date|
  PortsShip.create date: date, ship: Ship.all.sample, port: Port.all.sample
end unless PortsShip.exists?

Port.all.each do |port|
  rand(3).times do |i|
    Cargo.create title: "big containers ##{port.id}-#{i}", port_id: port.id, volume: rand(5..15)*1000, date: Date.today + rand(7).days
  end
end unless Cargo.exists?
