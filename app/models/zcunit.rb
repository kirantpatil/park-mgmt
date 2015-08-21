class Zcunit < ActiveRecord::Base
  validates :zcid, :ccunit_id, :presence => true
  has_many :lots, dependent: :destroy
  belongs_to :ccunit
end
