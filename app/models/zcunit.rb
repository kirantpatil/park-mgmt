class Zcunit < ActiveRecord::Base
  has_many :lots, dependent: :destroy
  belongs_to :ccunit
end
