require 'reloader/sse'

class ParkController < ApplicationController
  include ActionController::Live
 
  def index
    @buildings = Building.all
  end
	
  def index_stream
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)
    last_updated = Lot.last_updated.first

    if recently_changed? last_updated
      begin
        ccunit = last_updated.zcunit.ccunit
        floor = ccunit.floor
        a = ccunit.zcunits.pluck(:zcid)
        floor_status = f_status(floor)  

        for i in 0..a.size-1
        lot_status = l_status(ccunit.zcunits.find_by_zcid(a[i]))
        sse.write(lot_status, event: 'results')
        end
        sse.write(floor_status, event: 'results')

#        sse.write(ccunit, event: 'results')
      rescue IOError
        # When the client disconnects, we'll get an IOError on write
      ensure
        sse.close
      end
    end
  render nothing: true
  end

  private

  def f_status(floor)
    vacant = 0
    occupied = 0
    total = 0
    floor.ccunits.each do |ccu| 
      ccu.zcunits.each do |zcu|
        vacant += zcu.lots.where(status: "vacant").count
        occupied += zcu.lots.where(status: "Occupied").count
      end
    end
    total = vacant + occupied
    status = {:vacant => vacant, :occupied => occupied, :total => total}
    return status
  end

  def l_status(zcunit)
    a = ""
    zcunit.lots.each do |lot|
      if (lot.status == "vacant")
        a.concat("0")
      else
        a.concat("1")
      end
    end
    status = {:zcid => zcunit.zcid, :lstatus => a, :fname => zcunit.ccunit.floor.name}
    return status
  end

  def recently_changed? last_event
    last_event.created_at > 5.seconds.ago or
      last_event.updated_at > 5.seconds.ago
  end

 end
