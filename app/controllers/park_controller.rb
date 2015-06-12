require 'reloader/sse'

class ParkController < ApplicationController
  include ActionController::Live
 
  def index
    @events = Event.all
    @event = Event.find(1)
    #gon.pdata = @event.pdata
  end
	
  def index_stream
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)

    last_updated = Event.last_updated.first
    if recently_changed? last_updated
      begin
        sse.write(last_updated, event: 'results')
      rescue IOError
        # When the client disconnects, we'll get an IOError on write
      ensure
        sse.close
      end
    end
  render nothing: true
  end

  private

  def recently_changed? last_user
    last_user.created_at > 5.seconds.ago or
      last_user.updated_at > 5.seconds.ago
  end

end
