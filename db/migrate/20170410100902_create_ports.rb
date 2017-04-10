class CreatePorts < ActiveRecord::Migration
  def change
    create_table :ports do |t|
      t.string :title
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
