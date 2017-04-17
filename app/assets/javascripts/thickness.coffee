# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

advanced = true

$(document).ready ->
  $('.toggle-advanced-stats').click ->
    if advanced
      $('.advanced-stats').show()
      $('.basic-stats').hide()
      advanced = false
    else
      $('.advanced-stats').hide()
      $('.basic-stats').show()
      advanced = true