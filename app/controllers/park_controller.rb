require 'reloader/sse'

class ParkController < ApplicationController
  include ActionController::Live
 
  def index
  end
	
  def index_stream
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)
    last_updated = Event.last_updated.first

    if recently_changed? last_updated
      begin
        @events = Event.floor(last_updated.ccaddr)
        floor_status = f_status(@events)  
        sse.write(last_updated, event: 'results')
        sse.write(floor_status, event: 'results')
        # sse.write(@events[0].pdata, event: 'results')
      rescue IOError
        # When the client disconnects, we'll get an IOError on write
      ensure
        sse.close
      end
    end
  render nothing: true
  end

  private

  def f_status(f_events)
    vacant = 0
    filled = 0
    total = 0

    f_events.each do |i|
      #return i.pdata.size
      sdata = i.pdata
      sdatai = sdata.size.to_i
      total += sdatai
      a = sdata.split('')
      #return a[1]
      for j in 1..total
        if ( a[j] == "0" )
          vacant += 1 
        else
          filled += 1  
        end
        j += 1
      end
    end
    
    return filled
  end

  def recently_changed? last_event
    last_event.created_at > 5.seconds.ago or
      last_event.updated_at > 5.seconds.ago
  end

 end
