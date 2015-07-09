class Lot < ActiveRecord::Base
  belongs_to :zcunit

  scope :last_updated, -> {
    order('updated_at DESC, created_at DESC').limit(1)
  }
end
