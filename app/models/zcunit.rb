class Zcunit < ActiveRecord::Base
  validates :zcid, :ccunit_id, :presence => true
  has_many :lots, dependent: :destroy
  belongs_to :ccunit

  def self.l_status(zcunit, offset)
    a = ""
    a = zcunit.lots.order(:lotid).pluck(:status).join()
    status = {:zcid => zcunit.zcid, :lstatus => a, :fid => zcunit.ccunit.floor.id, :bid => zcunit.ccunit.floor.building.id, :offset => offset}
    return status
  end

end
