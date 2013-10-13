require 'open-uri'
require 'json'

class SearchApi

  def search(terms)
    return search_google(terms)
  end
  
  def search_google(terms)
    domain = "www.googleapis.com"
    path = "books/v1/volumes"
    key = "AIzaSyC5I4Bbh3Zy6jB1-HfHEijeoFelZ8Ir-uQ"
    referer = "rebook.herokuapp.com/"

    search_string = "https://#{domain}/#{path}?q=#{terms}&key=#{key}"
    search_string = search_string.gsub(" ", "%20")

    begin
      stream = open(search_string, "Referer" => referer)
      raise 'web service error' if (stream.status.first != '200')
      json =  JSON.parse(stream.read)

    rescue Exception => e
      puts e
      puts stream.read
      response = BookResponse.new
      response.status = "Unable to recieve json"
      return response
    end

    return parse_google(json)
  end

  def parse_google(json)

    response = BookResponse.new
    response.status = "Response ok"

    if(json.nil?)
      return response
    end

    json["items"].each do |x|
      book = Book.new
      begin
        book.title = x["volumeInfo"]["title"]
        puts book.title
        book.thumbnail = x["volumeInfo"]["imageLinks"]["thumbnail"]
        puts book.thumbnail
        response.books = response.books << book
      rescue
      end
    end

    return response
  end

  private :search_google, :parse_google

end

class Book
  attr_accessor :title, :thumbnail, :value, :link, :id, :author, :isbn
end

class BookResponse
  attr_accessor :status
  attr_writer :books

  def books
    @books ||= []
  end
end
