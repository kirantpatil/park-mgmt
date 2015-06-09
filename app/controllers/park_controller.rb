class ParkController < ApplicationController
	def index
	  @events = Event.all
	  @event = Event.find(1)
	  gon.pdata = @event.pdata
	end
end
