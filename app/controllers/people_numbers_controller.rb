class PeopleNumbersController < ApplicationController
  before_action :set_people_number, only: [:show, :edit, :update, :destroy]

  # GET /people_numbers
  # GET /people_numbers.json
  def index
    @people_numbers = PeopleNumber.all
  end

  # GET /people_numbers/1
  # GET /people_numbers/1.json
  def show
  end

  # GET /people_numbers/new
  def new
    @people_number = PeopleNumber.new
  end

  # GET /people_numbers/1/edit
  def edit
  end

  # POST /people_numbers
  # POST /people_numbers.json
  def create
    @people_number = PeopleNumber.new(people_number_params)

    respond_to do |format|
      if @people_number.save
        format.html { redirect_to @people_number, notice: 'People number was successfully created.' }
        format.json { render :show, status: :created, location: @people_number }
      else
        format.html { render :new }
        format.json { render json: @people_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people_numbers/1
  # PATCH/PUT /people_numbers/1.json
  def update
    respond_to do |format|
      if @people_number.update(people_number_params)
        format.html { redirect_to @people_number, notice: 'People number was successfully updated.' }
        format.json { render :show, status: :ok, location: @people_number }
      else
        format.html { render :edit }
        format.json { render json: @people_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people_numbers/1
  # DELETE /people_numbers/1.json
  def destroy
    @people_number.destroy
    respond_to do |format|
      format.html { redirect_to people_numbers_url, notice: 'People number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_people_number
      @people_number = PeopleNumber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def people_number_params
      params.require(:people_number).permit(:title)
    end
end
