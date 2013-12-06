class LocationsController < ApplicationController
  load_and_authorize_resource

  before_action :set_location, only: [:show, :edit, :update, :destroy, :location_books]
  before_action :set_query, only: [:location_books]

  # GET /locations
  # GET /locations.json
  def index
    @books = {}

    @locations = Location.all

    @locations.each do |location|
      @books[location.id] = Book.location_search(location.id, "")
    end

  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @books = {}

    @books[:books] = Book.location_search(@location.id, "")
    @result = Book.calculate_hidden(@books, session[:user_id])

    @conditions = Condition.all
  end

  def location_books
    @books = {}

    @books[:books] = Book.location_search(@location.id, "")
    @result = Book.calculate_hidden(@books, session[:user_id])
  end
  
  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    def set_query
      @query = params[:query] || ""
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :address, :city, :state, :zip, :image, :icon, :description)
    end
end
