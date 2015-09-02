class Floor < ActiveRecord::Base
  validates :name, :building_id, :image, :presence => true
  has_many :ccunits, dependent: :destroy
  belongs_to :building 
  has_attached_file :image, styles: {large: "600*600>", thumb:"150*150#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  def next
    building.floors.where("id > ?", id).first
  end

  def prev
    building.floors.where("id < ?", id).last
  end
end
