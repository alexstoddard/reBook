require 'open-uri'
require 'json'

:response_ok
:response_failed

class SearchApi

  def search(terms, limit)
    search = prepare_search_string(terms, limit)
    json = connect(search)
    books = parse(json)

    return books
  end
  
  def connect(search_string)
    referer = Rebook::Application.config.google_referer

    begin
      stream = open(search_string, "Referer" => referer)
      raise 'web service error' if (stream.status.first != '200')
      json =  JSON.parse(stream.read)
    rescue OpenURI::HTTPError => oe
      response = BookResponse.new
      response.status = :response_failed
      return response
    rescue Exception => e
      puts e
      response = BookResponse.new
      response.status = :response_failed
      return response
    end

  end

  def prepare_search_string(terms, limit)

    domain = Rebook::Application.config.google_domain
    path = Rebook::Application.config.google_path
    key = Rebook::Application.config.google_key

    limit ||= 10

    if(limit > 40)
      limit = 40
    end

    search_string = "https://#{domain}/#{path}?q=#{terms}&key=#{key}&country=US&maxResults=#{limit}"
    search_string = search_string.gsub(" ", "%20")

    return search_string
  end

  def parse(json)

    response = BookResponse.new
    response.status = :response_ok

    items = get_items(json)

    if(items.nil?)
      return response
    end

    items.each do |x|
      book = Book.new
      begin
        book.title = require_get(:get_title, x)
        book.thumbnail = require_get(:get_thumbnail, x)
        book.link = require_get(:get_link, x)
        book.id = require_get(:get_id, x)
        book.authors = optional_get(:get_authors, x)
        book.isbn = optional_get(:get_isbn,x)

        response.books = response.books << book
      rescue
      end
    end

    return response
  end

  def require_get(method, x)
    self.send method, x
  end

  def optional_get(method, x)
    begin
      self.send method, x
    rescue
    end
  end

  def get_items(json)
    return json["items"]
  end

  def get_isbn(x)
    return x["volumeInfo"]["industryIdentifiers"].find { |y| y['type'] == "ISBN_10" }['identifier']
  end

  def get_authors(x)
    return x["volumeInfo"]["authors"]
  end

  def get_id(x)
    return x["id"]
  end

  def get_title(x)
    return x["volumeInfo"]["title"]
  end

  def get_thumbnail(x)
    return x["volumeInfo"]["imageLinks"]["thumbnail"]
  end

  def get_link(x)
    return x["selfLink"]
  end

  private :connect, :parse, :prepare_search_string

end

class Book
  attr_accessor :title, :thumbnail, :link, :id, :authors, :isbn
end

class BookResponse
  attr_accessor :status
  attr_writer :books

  def books
    @books ||= []
  end
end
