class Ccunit < ActiveRecord::Base
  validates :ip, :port, :floor_id, :presence => true
  has_many :zcunits, dependent: :destroy
  belongs_to :floor
end
