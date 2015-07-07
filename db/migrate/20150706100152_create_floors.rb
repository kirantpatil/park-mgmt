class CreateFloors < ActiveRecord::Migration
  def change
    create_table :floors do |t|
      t.string :name
      t.string :image_url
      t.integer :building_id

      t.timestamps null: false
    end
  end
end
