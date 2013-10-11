require 'rubygems'
require 'json'
require 'net/http'

class GreetingsController < ApplicationController
  def hello
    @message = "Hello, from reBook!"
    @result = search_google("Stewart Calculus")
  end

  def search_google(terms)
    prefix = "https://www.googleapis.com/books/v1/volumes?q="
    api_key = "&key=AIzaSyBiCf7WbyUGR8kFOD3fwTAOjWGSMOGx4fk"

    search_string = prefix + terms + api_key
    resp = Net::HTTP.get_response(URI.parse(URI.encode(search_string)))
    data = resp.body

    return JSON.parse(data)
  end
end
