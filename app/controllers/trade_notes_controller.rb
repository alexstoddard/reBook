class TradeNotesController < ApplicationController
  load_and_authorize_resource
  before_action :set_trade_note, only: [:show, :edit, :update, :destroy]

  # GET /trade_notes
  # GET /trade_notes.json
  def index
    @trade_notes = TradeNote.all
  end

  # GET /trade_notes/1
  # GET /trade_notes/1.json
  def show
  end

  # GET /trade_notes/new
  def new
    @trade_note = TradeNote.new
  end

  # GET /trade_notes/1/edit
  def edit
  end

  # POST /trade_notes
  # POST /trade_notes.json
  def create
    @trade_note = TradeNote.new(trade_note_params)

    respond_to do |format|
      if @trade_note.save
        format.html { redirect_to @trade_note, notice: 'Trade note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trade_note }
      else
        format.html { render action: 'new' }
        format.json { render json: @trade_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_notes/1
  # PATCH/PUT /trade_notes/1.json
  def update
    respond_to do |format|
      if @trade_note.update(trade_note_params)
        format.html { redirect_to @trade_note, notice: 'Trade note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trade_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_notes/1
  # DELETE /trade_notes/1.json
  def destroy
    @trade_note.destroy
    respond_to do |format|
      format.html { redirect_to trade_notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_note
      @trade_note = TradeNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_note_params
      params.require(:trade_note).permit(:trade_id, :meet_time, :place, :comment, :user_id, :note_type)
    end
end
