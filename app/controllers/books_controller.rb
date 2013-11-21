require 'rubygems'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def self.add_if_nonexistant(api_id)
    book = Book.find_by_googleId(api_id)

    if book 
      return book
    end

    api = SearchApi.new
    result = api.search_book(api_id)
    
    if result.status == :response_ok
      book = Book.new

      book.author = result.book.authors
      book.name = result.book.title
      book.thumbnail = result.book.thumbnail
      book.googleId = result.book.id
      book.isbn = result.book.isbn
      book.description = result.book.description
      book.published = result.book.published

      if book.save
        return book
      end
    end
    
    return false
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # Show search results
	def search
    @conditions = Condition.all
		searcher = SearchApi.new

		query = params[:search] || ""

		if query 
		  @result = searcher.search(query, 40)
		end
		if session[:user_id]
			user_owns = InventoryOwn.find_all_by_user_id(session[:user_id])
			user_needs = InventoryNeed.find_all_by_user_id(session[:user_id])
			@result.books.each do |x|

				user_owns.each do |y|
					if y.book.googleId == x.id
						x.hide_own = true
					end        
				end

				user_needs.each do |y|
					if y.book.googleId == x.id
						x.hide_need = true
					end        
				end
			end
		end
	end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :subject, :author, :edition, :price, :googleId, :thumbnail)
    end
end
