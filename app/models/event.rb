class Event < ActiveRecord::Base

  scope :last_updated, -> {
    order('updated_at DESC, created_at DESC').limit(1)
  }

  def self.floor(addr)
    select('pdata').where(ccaddr: addr)
  end

end
