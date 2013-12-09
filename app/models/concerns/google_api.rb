require 'open-uri'
require 'json'

:response_ok
:response_failed

class GoogleApi

  def search(terms, limit)
    # Try 3 times and if fail, stop trying
    3.times do
      search = prepare_search_string(terms, limit)
      json = connect(search)
      books = parse(json, false)

      if books[:status] == :response_ok
          return books
      end
    end

    # Go to the database instead
    books = search_database(terms, limit)
    return books

  end

  def search_database(terms, limit) 
    response = { }
    response[:status] = :response_ok
    response[:books] = []
    
    columns = [:description, :name, :isbn, :author, :published]
    terms = terms.split.map {|term| "%" + term + "%"}
    combos = columns.product terms

    books = Book.where { combos.map { |tuple| __send__(tuple[0]).matches "#{tuple[1]}"}.inject(&:|)}.order(:name)

    books.each do |result|
      book = {}
      book[:name] = result.name
      book[:thumbnail] = result.thumbnail
      book[:googleId] = result.googleId
      book[:author] = result.author
      book[:isbn] = result.isbn
      book[:description] = result.description
      book[:published] = result.published
      response[:books] <<= book
    end

    return response
  end

  def search_book(id)
    search = prepare_book_string(id)
    json = connect(search)
    books = parse(json, true)

    return books
  end

  def connect(search_string)
    referer = Rebook::Application.config.google_referer

    begin
      stream = open(search_string, "Referer" => referer)
      raise 'web service error' if (stream.status.first != '200')
      json =  JSON.parse(stream.read)
    rescue OpenURI::HTTPError => oe
      return :response_failed
    rescue Exception => e
      return :response_failed
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

  def prepare_book_string(id)

    domain = Rebook::Application.config.google_domain
    path = Rebook::Application.config.google_path
    key = Rebook::Application.config.google_key

    search_string = "https://#{domain}/#{path}/#{id}?key=#{key}&country=US"
    search_string = search_string.gsub(" ", "%20")

    return search_string
  end

  def parse(json, single)

    response = { }
    response[:status] = :response_ok
    response[:books] = []

    if json == :response_failed
      response[:status] = :response_failed
      return response
    end

    if single
      book = parse_result(get_item(json))
      response[:book] = book
    else
      items = get_items(json)

      if items.nil?
        return response
      end

      items.each do |x|
        begin
          book = parse_result(x)
          response[:books] <<= book
        rescue
        end
      end
    end

    return response
  end
  
  def parse_result(x)

    book = { }

    book[:name] = require_get(:get_name, x)
    book[:thumbnail] = require_get(:get_thumbnail, x)
    book[:googleId] = require_get(:get_id, x)
    book[:author] = optional_get(:get_author, x)
    book[:isbn] = optional_get(:get_isbn,x)
    book[:description] = optional_get(:get_description,x)
    book[:published] = optional_get(:get_published,x)

    return book
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

  def get_item(json)
    return json
  end

  def get_items(json)
    begin
      return json["items"]
    rescue
      return []
    end
  end

  def get_isbn(x)
    return x["volumeInfo"]["industryIdentifiers"].find { |y| y['type'] == "ISBN_10" }['identifier']
  end

  def get_description(x)
    return x["volumeInfo"]["description"]
  end

  def get_published(x)
    return x["volumeInfo"]["publishedDate"]
  end

  def get_author(x)
    return x["volumeInfo"]["authors"].join(", ")
  end

  def get_id(x)
    return x["id"]
  end

  def get_name(x)
    return x["volumeInfo"]["title"]
  end

  def get_thumbnail(x)
    return x["volumeInfo"]["imageLinks"]["thumbnail"]
  end

  private :connect, :parse, :prepare_search_string

end
