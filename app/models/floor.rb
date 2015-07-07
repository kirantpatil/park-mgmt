class Floor < ActiveRecord::Base
  validates :name, :building_id, :presence => true
  has_many :ccunits, dependent: :destroy
  belongs_to :building 
end
