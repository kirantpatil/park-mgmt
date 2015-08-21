class Lot < ActiveRecord::Base
  validates :lotid, :status, :zcunit_id, :presence => true
  belongs_to :zcunit

  scope :last_updated, -> {
    order('updated_at DESC, created_at DESC').limit(1)
  }
end
