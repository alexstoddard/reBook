class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :destroy, :accept_trade, :decline_trade, :update_trade, :accept_trade_show, :accept_trade]
#  before_action :authorize_trade, except: [:my_trades, :matches, :propose_trade, :create]
  
  def authorize_trade
	@trade = Trade.find_by_id(params[:id].to_i)

    if not @trade.trade_lines.any?{|x| x.inventory_own.user_id == session[:user_id]}
      redirect_to root_url
    end

  end
  
  # GET /trades
  # GET /trades.json
  def index
#    authorize! :index, Trade
    @trades = Trade.all
  end
  
  def accept_trade_show
#    authorize! :accept_trade_show, Trade
    @trade = Trade.find_by_id(params[:id])
    @trade_note = TradeNote.new
    render :layout => "facebox"
  end
  
  def accept_trade
#	authorize! :accept_trade, Trade
    success = true

    Trade.transaction do

      @note = TradeNote.new(trade_note_params)
      @trade.user_accept(session[:user_id].to_i)
      @trade.append_note(session[:user_id], @note)

      if not @trade.proposable?
        success = false
        raise ActiveRecord::Rollback, "Cannot accept"
      end

      success = @trade.save

    end
    
    if not success
      flash[:notice] = "Failed accepting trade."
    end

    redirect_to "/trade_details/" + @trade.id.to_s

  end
  
  def decline_trade_show
#    authorize! :decline_trade_show, Trade
    @trade = Trade.find_by_id(params[:id])
    @trade_note = TradeNote.new
    render :layout => "facebox"
  end
  
  def decline_trade
#    authorize! :decline_trade, Trade
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
#    authorize! :update_trade_show, Trade
    @trade = Trade.find_by_id(params[:id])
    @trade_note = TradeNote.new
    render :layout => "facebox"
  end
  
  def update_trade 
#    authorize! :update_trade , Trade
    success = true

    Trade.transaction do

      @note = TradeNote.new(trade_note_params)
      @trade.user_update(session[:user_id].to_i)
      @trade.append_note(session[:user_id], @note)

      if not @trade.proposable?
        success = false
        raise ActiveRecord::Rollback, "Cannot update"
      end

      success = @trade.save
    end

    if not success
      flash[:notice] = "Failed updating trade."
    end

    redirect_to "/trade_details/" + @trade.id.to_s
  end
  
  def propose_trade
#    authorize! :propose_trade, Trade
    @trade = Trade.json_to_trade(params[:json])
    @trade_note = TradeNote.new
    @trade_note.user_id = params[:user_id]
    render :layout => "facebox"
  end
  
  def trade_details
    #BETWEEN HERE 
	#authorize! :trade_details, Trade
    @user = current_user
    if @user.nil?
      do_login
    else
      @trade = Trade.find_by_id(params[:trade_id])
	  #AND HERE, if id is NOT in database, then we have problem. 
	  #If exist, but its someone else id, will appropriately block access. 
	  if @trade == nil
		authorize! :trade_details, Trade
	  end
    end
  end

  # GET /matches_details/1
  # GET /matches_details/1.json
  def match_details
#    authorize! :match_details, Trade
    need_id = params[:id].to_i
    user_id = session[:user_id]

    @user = current_user
    @inventory_need = InventoryNeed.find(need_id)
    @book_matches = Trade.trades_by_need(user_id, need_id)

  end

  # GET /my_trades
  # GET /my_trades.json
  def my_trades
#    authorize! :my_trades, Trade
    user_id = session[:user_id]

    @user = User.find(user_id)
    @inventory_needs = InventoryNeed.find_all_by_user_id(user_id)
    @trade_hash = Trade.trades_by_status(user_id)
    @user_feedback = UserFeedback.new
  end

  # GET /matches
  # GET /matches.json
  def matches
#    authorize! :matches, Trade
    user_id = session[:user_id]

    @inventory_needs = InventoryNeed.where(deleted: false).find_all_by_user_id(user_id)
    @need_hash = Trade.trades_by_needs(user_id)
    @inventory_needs = Trade.order_needs_by_status(@inventory_needs, @need_hash)
    
  end

  # GET /trades/1
  # GET /trades/1.json
  def show
#    authorize! :show, Trade
  end

  # GET /trades/new
  def new
#    authorize! :index, Trade
    @trade = Trade.new
  end

  # GET /trades/1/edit
  def edit
#    authorize! :edit, Trade
  end

  # POST /trades
  # POST /trades.json
  def create
#    authorize! :create, Trade
    success = true

    Trade.transaction do
      
      @trade = Trade.json_to_trade(params[:trade_note][:json])

      if not @trade.proposable?
        success = false
        raise ActiveRecord::Rollback, "Cannot propose"
      end

      @note = TradeNote.new(trade_note_params)
      @trade.user_accept(session[:user_id])
      @trade.append_note(session[:user_id], @note)
      success = @trade.save

    end

    respond_to do |format|
      if success
        UserMailer.trade_email(@trade).deliver
        format.html { 
          redirect_to '/trade_details/'"#{@trade.id}"
          flash[:success] = 'Trade was successfully created.' 
        }
        format.json { render action: 'show', status: :created, location: @trade }
      else
        format.html { redirect_to matches_path, notice: 'Trade could not be proposed.' }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1
  # PATCH/PUT /trades/1.json
  def update
 #   authorize! :update, Trade
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { 
          redirect_to @trade
          flash[:success] = 'Trade was successfully updated.' 
        }
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
#    authorize! :destroy, Trade
    @trade.destroy
    respond_to do |format|
      format.html { redirect_to trades_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade
#      authorize! :set_trade, Trade
      @trade = Trade.find(params[:id].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_params
      params.require(:trade).permit(:status, :location_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_note_params
      params.require(:trade_note).permit(:meet_time, :place, :comment, :note_type)
    end
end
