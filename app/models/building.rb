class Building < ActiveRecord::Base
  has_many :floors, dependent: :destroy

  def self.b_status(building)
    vacant = 0
    occupied = 0
    reserved = 0
    total = 0
    building.floors.each do |flr|
      flr.ccunits.each do |ccu|
        ccu.zcunits.each do |zcu|
          vacant += zcu.lots.where(status: "v").count
          occupied += zcu.lots.where(status: "o").count
          reserved += zcu.lots.where(status: "r").count
        end
      end
    end
    total = vacant + occupied + reserved
    status = {:vacant_b => vacant, :occupied_b => occupied, :reserved_b => reserved, :total_b => total, :bid => building.id}
    return status
  end

end
