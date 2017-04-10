class CreatePortsShips < ActiveRecord::Migration
  def change
    create_table :ports_ships do |t|
      t.integer :port_id
      t.integer :ship_id
      t.date :date

      t.timestamps null: false
    end
  end
end
