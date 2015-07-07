class CreateCcunits < ActiveRecord::Migration
  def change
    create_table :ccunits do |t|
      t.string :ip
      t.integer :port
      t.integer :floor_id

      t.timestamps null: false
    end
  end
end
