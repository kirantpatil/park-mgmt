class CreateZcunits < ActiveRecord::Migration
  def change
    create_table :zcunits do |t|
      t.integer :zcid
      t.integer :ccunit_id

      t.timestamps null: false
    end
  end
end
