class Building < ActiveRecord::Base
  has_many :floors, dependent: :destroy
end
