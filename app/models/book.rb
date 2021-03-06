class Book < ActiveRecord::Base

  # Attributes
  attr_accessor :hide_own, :hide_need

  # Relationships
  has_many :inventory_needs, dependent: :destroy
  has_many :inventory_owns, dependent: :destroy

  # Callbacks
  after_initialize :set_defaults

  def self.location_search(location, terms, page) 

    all_books = Book.joins(:inventory_owns => { :user => :user_locations }).where("user_locations.location_id = ?", location).where("inventory_owns.deleted = ?", false).distinct

    columns = [:description, :name, :isbn, :author, :published]
    terms = terms.split.map {|term| "%" + term + "%"}
    combos = columns.product terms

    page ||= 1

    books = all_books.where { combos.map { |tuple| __send__(tuple[0]).matches "#{tuple[1]}"}.inject(&:|)}.order(:name).paginate(page: page, per_page: 10)

    return books
  end

  def self.results_string(books, location, terms)

    location_string = " at " + location

    if terms.nil? or terms.empty?
      matching_string = ""
    else
      matching_string = " matching '" + terms + "'"
    end

    from = ((((books.current_page-1)*books.per_page)+1))
    to = (from + books.per_page - 1) > books.total_entries ? books.total_entries : (from + books.per_page - 1)

    from = from.to_s
    to = to.to_s

    if books.total_entries == 0
      message = "Found no books"
      displaying = ""
    elsif books.total_entries == 1
      message = "Found 1 book"
      displaying = ""
    elsif
      message = "Found " + books.total_entries.to_s + " total books"
      displaying = ", displaying results " + from + " to " + to
    end

    return message + location_string + matching_string + displaying

  end

  def needs_in_location(location) 
    inventory_needs.where(deleted: false).joins(:user => :user_locations).where("user_locations.location_id = ?", location).size
  end

  def owns_in_location(location)
    inventory_owns.where(deleted:false).joins(:user => :user_locations).where("user_locations.location_id = ?", location).size
  end

  def self.search(terms, page)

    api = GoogleApi.new
    results = api.search(terms, page)

    total = results[:total]
    
    books = {}
    books[:books] = []
    books[:status] = results[:status]
        
    results[:books].each do |b|
      book = Book.new(b)
      books[:books] <<= book
    end

    books[:books] = books[:books].paginate(page: page, per_page: 10, total_entries: total)

    return books

  end

  def self.calculate_hidden(books, user_id)
    if user_id
			user_owns = InventoryOwn.all.includes(:book).find_all_by_user_id(user_id)
			user_needs = InventoryNeed.all.includes(:book).find_all_by_user_id(user_id)

			books[:books].each do |x|

				user_owns.each do |y|
					if y.book.googleId == x.googleId and y.deleted == false
						x.hide_own = true
					end        
				end

				user_needs.each do |y|
					if y.book.googleId == x.googleId and y.deleted == false
						x.hide_need = true
					end        
				end
			end
		end

    return books
  end

  def save_book
    book = Book.find_by_googleId(self.googleId)

    if book 
      assign_attributes(book.attributes)
      return
    else
      save
    end
  end

  def set_defaults
    self.hide_own = false
    self.hide_need = false
  end

end

class Array
  def paginate(options = {})
    page     = options[:page]
    per_page = options[:per_page]
    total    = options[:total_entries]

    WillPaginate::Collection.create(page, per_page, total) do |pager|
      pager.replace self
    end
  end
end
