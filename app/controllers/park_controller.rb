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

  def new_res(status, ss)
  status.pdata.size.times do |n|
  ss += 1 if status.pdata[n] == "1"
  end
  return ss
  end

end
