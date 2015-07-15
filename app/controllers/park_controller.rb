class ParkController < ApplicationController
 
  def index
    @buildings = Building.all
  end
	
end
