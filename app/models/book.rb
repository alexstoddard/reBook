class Book < ActiveRecord::Base

  # Attributes
  attr_accessor :hide_own, :hide_need

  # Relationships
  has_many :inventory_needs, dependent: :destroy
  has_many :inventory_owns, dependent: :destroy

  # Callbacks
  after_initialize :set_defaults

  def self.search(terms, limit)

    api = GoogleApi.new
    results = api.search(terms, limit)

    books = {}
    books[:books] = []
    books[:status] = results[:status]
    
    results[:books].each do |b|
      book = Book.new(b)
      books[:books] <<= book
    end

    return books;
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
