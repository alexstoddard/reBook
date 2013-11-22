# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery($).ready ->
  $('#searcher').keyup ->
     $('#location_form').submit() 

jQuery($).ready ->
  $('#loclist a').live("click") ->
     $.getScript(this.href)
