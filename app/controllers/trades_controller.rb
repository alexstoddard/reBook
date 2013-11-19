class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :destroy]

  # GET /trades
  # GET /trades.json
  def index
    @trades = Trade.all
  end
  
  def json_to_trade(json)
    trade = Trade.new

    json["trade_lines"].each do |x|
      line = trade.trade_lines.build()
      line.user_from_id = x["user_from_id"]
      line.user_to_id = x["user_to_id"]
      line.book_id = x["book_id"]
    end
    
    return trade

  end

  def propose_trade
    @trade = json_to_trade(ActiveSupport::JSON.decode(params[:json]))
    render :layout => "facebox"
  end

  def match_details
    @book_id = params[:id]
    @book_matches = []
    @trades = Trade.try_matches(session[:user_id])
    @book = Book.find(@book_id)
    puts "book_id:" + @book_id
    @trades.each do |x|
      puts x.trade_lines[x.trade_lines.length-1].book_id
      if x.trade_lines[x.trade_lines.length-1].book_id == @book_id.to_i
        puts "hello"
        @book_matches <<= x
      end
    end

  end

  def matches
    @book_hash = { }
    @trades = Trade.try_matches(session[:user_id])
    @inventory_needs = InventoryNeed.find_all_by_user_id(session[:user_id])
    
    @trades.each do |x|
      found_id = x.trade_lines[x.trade_lines.length-1].book_id

      if @book_hash[found_id].nil?
        @book_hash[found_id] = []
      end

      @book_hash[found_id] <<= x

    end

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
    @trade = Trade.new(trade_params)

    respond_to do |format|
      if @trade.save
        format.html { redirect_to @trade, notice: 'Trade was successfully created.' }
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
      @trade = Trade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_params
      params.require(:trade).permit(:status)
    end
end
