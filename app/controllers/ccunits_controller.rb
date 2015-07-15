class CcunitsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_ccunit, only: [:show, :edit, :update, :destroy]

  # GET /ccunits
  # GET /ccunits.json
  def index
    @ccunits = Ccunit.all
  end

  # GET /ccunits/1
  # GET /ccunits/1.json
  def show
  end

  # GET /ccunits/new
  def new
    @ccunit = Ccunit.new
  end

  # GET /ccunits/1/edit
  def edit
  end

  # POST /ccunits
  # POST /ccunits.json
  def create
    @ccunit = Ccunit.new(ccunit_params)

    respond_to do |format|
      if @ccunit.save
        format.html { redirect_to @ccunit, notice: 'Ccunit was successfully created.' }
        format.json { render :show, status: :created, location: @ccunit }
      else
        format.html { render :new }
        format.json { render json: @ccunit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ccunits/1
  # PATCH/PUT /ccunits/1.json
  def update
    respond_to do |format|
      if @ccunit.update(ccunit_params)
        format.html { redirect_to @ccunit, notice: 'Ccunit was successfully updated.' }
        format.json { render :show, status: :ok, location: @ccunit }
      else
        format.html { render :edit }
        format.json { render json: @ccunit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ccunits/1
  # DELETE /ccunits/1.json
  def destroy
    @ccunit.destroy
    respond_to do |format|
      format.html { redirect_to ccunits_url, notice: 'Ccunit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ccunit
      @ccunit = Ccunit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ccunit_params
      params.require(:ccunit).permit(:ip, :port, :floor_id)
    end
end
