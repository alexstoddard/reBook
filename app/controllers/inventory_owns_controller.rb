class InventoryOwnsController < ApplicationController
  load_and_authorize_resource
  before_action :set_inventory_own, only: [:show, :edit, :update, :destroy]

  # GET /inventory_owns
  # GET /inventory_owns.json
  def index
    if session[:user_id].nil?
      @inventory_owns = InventoryOwn.all
    else
      @conditions = Condition.all
      @inventory_owns = InventoryOwn.where(deleted: false).find_all_by_user_id(session[:user_id])
    end
  end

  # GET /inventory_owns/1
  # GET /inventory_owns/1.json
  def show
  end

  # GET /inventory_owns/new
  def new
    @inventory_own = InventoryOwn.new
  end

  # GET /inventory_owns/1/edit
  def edit
  end

  # POST /inventory_owns
  # POST /inventory_owns.json
  def create

    @book = Book.new(book_params)
    @book.save_book

    own = InventoryOwn.find_by_book_id_and_user_id(@book.id, session[:user_id])
    need = InventoryNeed.find_by_book_id_and_user_id(@book.id, session[:user_id])

    unless (need and need.deleted == false) or (own and own.deleted == false)
      @inventory_own = InventoryOwn.new
      @inventory_own.book_id = @book.id
      @inventory_own.user_id = session[:user_id]
      @inventory_own.condition_id = params[:condition_id]
      @inventory_own.deleted = false

      respond_to do |format|
        if @inventory_own.save
          format.html { redirect_to search_path + "?" + params[:search].to_query("search") }
          format.json { render action: 'show', status: :created, location: @inventory_own }
        else
          format.html { render action: 'new' }
          format.json { render json: @inventory_own.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to search_path + "?" + params[:search].to_query("search")
    end
  end
 
  # PATCH/PUT /inventory_owns/1
  # PATCH/PUT /inventory_owns/1.json
  def update
    respond_to do |format|
      if @inventory_own.update(inventory_own_params)
        format.html { redirect_to @inventory_own }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inventory_own.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_owns/1
  # DELETE /inventory_owns/1.json
  def destroy

    InventoryOwn.transaction do
      @inventory_own.deleted = true
      @inventory_own.save

      user_id = @inventory_own.user_id

      #If the book being removed is involved in a trade, email other users involved in trade that the trade
      #has been cancelled
      @trades = @inventory_own.trades
      debugger
        @trades.each do |trade|

          if not trade.declined?
            trade.user_decline(user_id, "Sorry, I removed this item from my have list.")

            @trade_lines = trade.get_tradelines_except(user_id)
            @trade_lines.each do |line|
              UserMailer.trade_destroyed(line.inventory_own.user, trade).deliver
            end
          end
        end

    end

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_own
      @inventory_own = InventoryOwn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_own_params
      params.require(:inventory_own).permit(:book_id, :user_id, :condition_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:id, :name, :subject, :author, :edition, :price, :googleId, :thumbnail, :isbn, :published, :description)
    end
end
