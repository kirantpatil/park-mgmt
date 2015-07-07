class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.integer :lotid
      t.string :status
      t.datetime :stime
      t.datetime :etime
      t.integer :zcunit_id

      t.timestamps null: false
    end
  end
end
