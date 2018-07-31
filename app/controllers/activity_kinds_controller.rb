class ActivityKindsController < ApplicationController
prepend_before_action :require_no_authentication, only: [:cancel]
  before_action :set_activity_kind, only: [:show, :edit, :update, :destroy]

  # GET /activity_kinds
  # GET /activity_kinds.json
  def index
    @activity_kinds = ActivityKind.all
  end

  # GET /activity_kinds/1
  # GET /activity_kinds/1.json
  def show
  end

  # GET /activity_kinds/new
  def new
    @activity_kind = ActivityKind.new
  end

  # GET /activity_kinds/1/edit
  def edit
  end

  # POST /activity_kinds
  # POST /activity_kinds.json
  def create
    @activity_kind = ActivityKind.new(activity_kind_params)

    respond_to do |format|
      if @activity_kind.save
        format.html { redirect_to @activity_kind, notice: 'Activity kind was successfully created.' }
        format.json { render :show, status: :created, location: @activity_kind }
      else
        format.html { render :new }
        format.json { render json: @activity_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_kinds/1
  # PATCH/PUT /activity_kinds/1.json
  def update
    respond_to do |format|
      if @activity_kind.update(activity_kind_params)
        format.html { redirect_to @activity_kind, notice: 'Activity kind was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_kind }
      else
        format.html { render :edit }
        format.json { render json: @activity_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_kinds/1
  # DELETE /activity_kinds/1.json
  def destroy
    @activity_kind.destroy
    respond_to do |format|
      format.html { redirect_to activity_kinds_url, notice: 'Activity kind was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_kind
      @activity_kind = ActivityKind.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_kind_params
      params.require(:activity_kind).permit(:title)
    end
end
