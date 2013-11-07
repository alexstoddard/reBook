require 'rubygems'
require 'json'
require 'net/http'

class GreetingsController < ApplicationController
  def hello
    searcher = SearchApi.new

    @message = "Hello, from reBook!"
    query = params[:search] || "Stewart Calculus" 
    @result = searcher.search(query, 40)
	
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
end
