class InventoryNeedsController < ApplicationController
  load_and_authorize_resource
  before_action :set_inventory_need, only: [:show, :edit, :update, :destroy]

  # GET /inventory_needs
  # GET /inventory_needs.json
  def index
    if session[:user_id].nil?
      @inventory_needs = InventoryNeed.all
    else
      @inventory_needs = InventoryNeed.where(deleted: false).find_all_by_user_id(session[:user_id])
    end
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
    @book = Book.new(book_params)
    @book.save_book

    need = InventoryNeed.find_by_book_id_and_user_id(@book.id, session[:user_id])
    own = InventoryOwn.find_by_book_id_and_user_id(@book.id, session[:user_id])

    unless (need and need.deleted == false) or (own and own.deleted == false)
      @inventory_need = InventoryNeed.new
      @inventory_need.book_id = @book.id
      @inventory_need.user_id = session[:user_id]
      @inventory_need.deleted = false

      respond_to do |format|
        if @inventory_need.save
          format.html { redirect_to search_path + "?" + params[:search].to_query("search")  }
          format.json { render action: 'index', status: :created, location: @inventory_need }
        else
          format.html { render action: 'new' }
          format.json { render json: @inventory_need.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to search_path + "?" + params[:search].to_query("search")
    end
  end

  # PATCH/PUT /inventory_needs/1
  # PATCH/PUT /inventory_needs/1.json
  def update
    respond_to do |format|
      if @inventory_need.update(inventory_need_params)
        format.html { redirect_to @inventory_need }
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

    @inventory_need.deleted = true
    @inventory_need.save
	
	#If the book being removed is involved in a trade, email other users involved in trade that the trade
	#has been cancelled
    @all_trade_lines = TradeLine.find_all_inventory_need_id(@inventory_need.id)
    if(!@trade_line.nil?)
		@all_trade_lines.each do |y|
		  @trade = Trade.find(y.trade_id)
		  @trade_lines = @trade.get_tradelines_except(session[:user_id])
		  @trade_lines.each do |x|
			UserMailer.trade_destroyed(x.inventory_own.user, @trade).deliver
		  end
		end
    end

    respond_to do |format|
      format.html { redirect_to inventory_needs_url }
      format.json { head :no_content }
      format.js { render :layout=>false }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:id, :name, :subject, :author, :edition, :price, :googleId, :thumbnail, :isbn, :published, :description)
    end
end
