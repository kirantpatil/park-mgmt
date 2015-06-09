class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :pdata

      t.timestamps null: false
    end
  end
end
