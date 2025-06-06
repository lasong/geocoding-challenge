class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :street
      t.string :city
      t.string :zip
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
