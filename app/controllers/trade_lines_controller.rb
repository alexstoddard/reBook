class TradeLinesController < ApplicationController
  load_and_authorize_resource
  before_action :set_trade_line, only: [:show, :edit, :update, :destroy]

  # GET /trade_lines
  # GET /trade_lines.json
  def index
    @trade_lines = TradeLine.all
  end

  # GET /trade_lines/1
  # GET /trade_lines/1.json
  def show
  end

  # GET /trade_lines/new
  def new
    @trade_line = TradeLine.new
  end

  # GET /trade_lines/1/edit
  def edit
  end

  # POST /trade_lines
  # POST /trade_lines.json
  def create
    @trade_line = TradeLine.new(trade_line_params)

    respond_to do |format|
      if @trade_line.save
        format.html { redirect_to @trade_line, notice: 'Trade line was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trade_line }
      else
        format.html { render action: 'new' }
        format.json { render json: @trade_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_lines/1
  # PATCH/PUT /trade_lines/1.json
  def update
    respond_to do |format|
      if @trade_line.update(trade_line_params)
        format.html { redirect_to @trade_line, notice: 'Trade line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trade_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_lines/1
  # DELETE /trade_lines/1.json
  def destroy
    @trade_line.destroy
    respond_to do |format|
      format.html { redirect_to trade_lines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_line
      @trade_line = TradeLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_line_params
      params.require(:trade_line).permit(:user_from_id, :book_id, :user_to_id, :user_from_accepted, :status)
    end
end
