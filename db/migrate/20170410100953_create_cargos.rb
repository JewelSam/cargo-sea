class CreateCargos < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
      t.string :title
      t.integer :port_id
      t.date :date
      t.integer :volume

      t.timestamps null: false
    end
  end
end
