class Floor < ActiveRecord::Base
  validates :name, :building_id, :image_url, :presence => true
  has_many :ccunits, dependent: :destroy
  belongs_to :building 

  def self.f_status(floor)
    vacant = 0
    occupied = 0
    reserved = 0
    total = 0
      floor.ccunits.each do |ccu|
          ccu.zcunits.each do |zcu|
            vacant += zcu.lots.where(status: "v").count
            occupied += zcu.lots.where(status: "o").count
            reserved += zcu.lots.where(status: "r").count
          end
        end
    total = vacant + occupied + reserved
    status = {:vacant => vacant, :occupied => occupied, :reserved => reserved , :total => total, :fid => floor.id, :bid => floor.building.id}
    return status
  end

  def self.book_lot(bid, fid, zid, lid, status)
    @building = Building.find_by_id(bid)
    ccu = @building.floors.find_by_id(fid).ccunits.first
    zcu = ccu.zcunits.find_by_zcid(zid)
    lot = zcu.lots.find_by_lotid(lid)
    lot.status = status
    lot.save
    return ccu, zcu, lot
  end

  
  def next
    building.floors.where("id > ?", id).first
  end

  def prev
    building.floors.where("id < ?", id).last
  end
end
