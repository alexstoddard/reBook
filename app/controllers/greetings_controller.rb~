require 'rubygems'
require 'json'
require 'net/http'

class GreetingsController < ApplicationController
  def hello
    searcher = SearchApi.new

    @message = "Hello, from reBook!"
    query = params[:search] || "Stewart Calculus" 
    @result = searcher.search(query, 40)

  end
end
