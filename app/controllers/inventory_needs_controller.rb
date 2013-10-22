class InventoryNeedsController < ApplicationController
  before_action :set_inventory_need, only: [:show, :edit, :update, :destroy]

  # GET /inventory_needs
  # GET /inventory_needs.json
  def index
    @inventory_needs = InventoryNeed.all
  end

  # GET /inventory_needs/1
  # GET /inventory_needs/1.json
  def show
  end

  # GET /inventory_needs/new
  def new
    @inventory_need = InventoryNeed.new
  end

  # GET /inventory_needs/1/edit
  def edit
  end

  # POST /inventory_needs
  # POST /inventory_needs.json
  def create
    @inventory_need = InventoryNeed.new(inventory_need_params)

    respond_to do |format|
      if @inventory_need.save
        format.html { redirect_to @inventory_need, notice: 'Inventory need was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inventory_need }
      else
        format.html { render action: 'new' }
        format.json { render json: @inventory_need.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_needs/1
  # PATCH/PUT /inventory_needs/1.json
  def update
    respond_to do |format|
      if @inventory_need.update(inventory_need_params)
        format.html { redirect_to @inventory_need, notice: 'Inventory need was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inventory_need.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_needs/1
  # DELETE /inventory_needs/1.json
  def destroy
    @inventory_need.destroy
    respond_to do |format|
      format.html { redirect_to inventory_needs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_need
      @inventory_need = InventoryNeed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_need_params
      params.require(:inventory_need).permit(:book_id, :user_id)
    end
end