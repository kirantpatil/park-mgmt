require 'reloader/sse'

class FloorsController < ApplicationController
  include ActionController::Live
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_floor, only: [:show, :edit, :update, :destroy]

  def floor_stream
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)
    last_updated = Lot.last_updated.first

    if recently_changed? last_updated
      begin
        ccunit = last_updated.zcunit.ccunit
        floor = ccunit.floor
        building = ccunit.floor.building
        a = ccunit.zcunits.pluck(:zcid)
        floor_status = f_status(floor)
        building_status = b_status(building)

        for i in 0..a.size-1
          lot_status = l_status(ccunit.zcunits.find_by_zcid(a[i]))
          sse.write(lot_status, event: 'results')
        end

        sse.write(floor_status, event: 'results')
        sse.write(building_status, event: 'results')
      rescue ClientDisconnected
        # When the client disconnects, we'll get an IOError on write
        logger.info "Stream closed"
      ensure
        logger.info "Stopping stream thread"
        sse.close
      end
    end
    render nothing: true
  end


  # GET /floors
  # GET /floors.json
  def index
    @floors = Floor.all
  end

  # GET /floors/1
  # GET /floors/1.json
  def show
  end

  # GET /floors/new
  def new
    @floor = Floor.new
    @buildings = Building.all
  end

  # GET /floors/1/edit
  def edit
    @buildings = Building.all
    puts params.inspect
  end
 
  # POST /floors
  # POST /floors.json
  def create
    @floor = Floor.new(floor_params)

    respond_to do |format|
      if @floor.save
        format.html { redirect_to @floor, notice: 'Floor was successfully created.' }
        format.json { render :show, status: :created, location: @floor }
      else
        format.html { render :new }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /floors/1
  # PATCH/PUT /floors/1.json
  def update
    respond_to do |format|
      if @floor.update(floor_params)
        format.html { redirect_to @floor, notice: 'Floor was successfully updated.' }
        format.json { render :show, status: :ok, location: @floor }
      else
        format.html { render :edit }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /floors/1
  # DELETE /floors/1.json
  def destroy
    @floor.destroy
    respond_to do |format|
      format.html { redirect_to floors_url, notice: 'Floor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_floor
      @floor = Floor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def floor_params
      params.require(:floor).permit(:name, :image_url, :building_id)
    end

    def b_status(building)
    vacant = 0
    occupied = 0
    total = 0
    building.floors.each do |flr|
      flr.ccunits.each do |ccu|
        ccu.zcunits.each do |zcu|
          vacant += zcu.lots.where(status: "vacant").count
          occupied += zcu.lots.where(status: "Occupied").count
        end
      end
    end
    total = vacant + occupied
    status = {:vacant_b => vacant, :occupied_b => occupied, :total_b => total}
    return status
    end


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
    status = {:zcid => zcunit.zcid, :lstatus => a, :fname => zcunit.ccunit.floor.name, :bname => zcunit.ccunit.floor.building.name}
    return status
  end

  def recently_changed? last_event
    last_event.created_at > 5.seconds.ago or
      last_event.updated_at > 5.seconds.ago
  end

end
