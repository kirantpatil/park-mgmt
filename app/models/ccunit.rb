class Ccunit < ActiveRecord::Base
  has_many :zcunits, dependent: :destroy
  belongs_to :floor
end
