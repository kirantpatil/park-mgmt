class AddAttachmentImageToFloors < ActiveRecord::Migration
  def self.up
    change_table :floors do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :floors, :image
  end
end
