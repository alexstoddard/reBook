class InventoryHavesController < ApplicationController
  before_action :set_inventory_hafe, only: [:show, :edit, :update, :destroy]

  # GET /inventory_haves
  # GET /inventory_haves.json
  def index
    @inventory_haves = InventoryHave.all
  end

  # GET /inventory_haves/1
  # GET /inventory_haves/1.json
  def show
  end

  # GET /inventory_haves/new
  def new
    @inventory_hafe = InventoryHave.new
  end

  # GET /inventory_haves/1/edit
  def edit
  end

  # POST /inventory_haves
  # POST /inventory_haves.json
  def create
    @inventory_hafe = InventoryHave.new(inventory_hafe_params)

    respond_to do |format|
      if @inventory_hafe.save
        format.html { redirect_to @inventory_hafe, notice: 'Inventory have was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inventory_hafe }
      else
        format.html { render action: 'new' }
        format.json { render json: @inventory_hafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_haves/1
  # PATCH/PUT /inventory_haves/1.json
  def update
    respond_to do |format|
      if @inventory_hafe.update(inventory_hafe_params)
        format.html { redirect_to @inventory_hafe, notice: 'Inventory have was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inventory_hafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_haves/1
  # DELETE /inventory_haves/1.json
  def destroy
    @inventory_hafe.destroy
    respond_to do |format|
      format.html { redirect_to inventory_haves_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_hafe
      @inventory_hafe = InventoryHave.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_hafe_params
      params.require(:inventory_hafe).permit(:book_id, :user_id, :condition_id)
    end
end
