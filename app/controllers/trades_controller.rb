class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :destroy, :accept_trade, :decline_trade, :update_trade, :accept_trade_show, :accept_trade]

  # GET /trades
  # GET /trades.json
  def index
    @trades = Trade.all
  end
  
  def accept_trade_show
    @trade_note = TradeNote.new
    render :layout => "facebox"
  end
  
  def accept_trade

    @note = TradeNote.new(trade_note_params)
    @trade.user_accept(session[:user_id].to_i)
    @trade.append_note(session[:user_id], @note)
    @trade.save

    redirect_to "/trade_details/" + @trade.id.to_s

  end
  
  def decline_trade_show
    @trade_note = TradeNote.new
    render :layout => "facebox"
  end
  
  def decline_trade
    @note = TradeNote.new(trade_note_params)
    @trade.user_decline(session[:user_id].to_i)
    @trade.append_note(session[:user_id], @note)
    @trade.save

    #redirect to match_details page for the book the user wants
    redirect_to "/match_details/" + @trade.get_tradeline_from(session[:user_id]).inventory_need.id.to_s

    #respond_to do |format|
    #  if @trade.save
    #    format.js {}
    #  end
    #end
  end
  
  def update_trade_show
    @trade_note = TradeNote.new
    render :layout => "facebox"
  end
  
  def update_trade 
    @note = TradeNote.new(trade_note_params)
    @trade.user_update(session[:user_id].to_i)
    @trade.append_note(session[:user_id], @note)
    @trade.save

    redirect_to "/trade_details/" + @trade.id.to_s
  end
  
  def propose_trade
    @trade = Trade.json_to_trade(params[:json])
    @trade_note = TradeNote.new
    @trade_note.user_id = params[:user_id]
    render :layout => "facebox"
  end
  
  def trade_details
    @user = current_user
    if @user.nil?
      do_login
    else
      @trade = Trade.find_by_id(params[:trade_id])
    end
  end

  # GET /matches_details/1
  # GET /matches_details/1.json
  def match_details
    need_id = params[:id].to_i
    user_id = session[:user_id]

    @user = current_user
    @inventory_need = InventoryNeed.find(need_id)
    @book_matches = Trade.trades_by_need(user_id, need_id)

  end

  # GET /my_trades
  # GET /my_trades.json
  def my_trades

    user_id = session[:user_id]

    @inventory_needs = InventoryNeed.find_all_by_user_id(user_id)
    @need_hash = Trade.trades_by_needs(user_id)

  end

  # GET /matches
  # GET /matches.json
  def matches

    user_id = session[:user_id]

    @inventory_needs = InventoryNeed.find_all_by_user_id(user_id)
    @need_hash = Trade.trades_by_needs(user_id)

  end

  # GET /trades/1
  # GET /trades/1.json
  def show
  end

  # GET /trades/new
  def new
    @trade = Trade.new
  end

  # GET /trades/1/edit
  def edit
  end

  # POST /trades
  # POST /trades.json
  def create

    @trade = Trade.json_to_trade(params[:trade_note][:json])
    @note = TradeNote.new(trade_note_params)
    @trade.user_accept(session[:user_id])
    @trade.append_note(session[:user_id], @note)

    respond_to do |format|
      if @trade.save
        UserMailer.trade_email(@trade).deliver
        format.html { redirect_to Rebook::Application::REBOOK_DOMAIN + '/trade_details/'"#{@trade.id}", notice: 'Trade was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trade }
      else
        format.html { render action: 'new' }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1
  # PATCH/PUT /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to @trade, notice: 'Trade was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trades/1
  # DELETE /trades/1.json
  def destroy
    @trade.destroy
    respond_to do |format|
      format.html { redirect_to trades_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade
      @trade = Trade.find(params[:id].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_params
      params.require(:trade).permit(:status)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_note_params
      params.require(:trade_note).permit(:meet_time, :place, :comment)
    end
end
