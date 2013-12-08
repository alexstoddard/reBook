class HomepageController < ApplicationController
  skip_before_filter :validate_user
  #root
  def index
    @locations = Location.all 
  end

  #/terms
  def terms
  end

  #/about
  def about
  end

  #/faq
  def faq
  end

end