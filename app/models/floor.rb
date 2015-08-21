class Floor < ActiveRecord::Base
  validates :name, :building_id, :presence => true
  has_many :ccunits, dependent: :destroy
  belongs_to :building 
  
  def next
    building.floors.where("id > ?", id).first
  end

  def prev
    building.floors.where("id < ?", id).last
  end
end
