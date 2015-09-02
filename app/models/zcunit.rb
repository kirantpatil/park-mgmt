class Zcunit < ActiveRecord::Base
  validates :zcid, :ccunit_id, :presence => true
  has_many :lots, dependent: :destroy
  belongs_to :ccunit

  def self.l_status(zcunit, offset)
    a = ""
    zcunit.lots.order(:lotid).each do |lot|
      a.concat(lot.status)
    end
    status = {:zcid => zcunit.zcid, :lstatus => a, :fid => zcunit.ccunit.floor.id, :bid => zcunit.ccunit.floor.building.id, :offset => offset}
    return status
  end

end
