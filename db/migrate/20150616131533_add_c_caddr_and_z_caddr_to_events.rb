class AddCCaddrAndZCaddrToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ccaddr, :string
    add_column :events, :ccport, :integer
    add_column :events, :zcaddr, :integer
  end
end
