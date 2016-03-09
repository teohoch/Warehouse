# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#invoice_payment_deadline").datepicker
    dateFormat: 'yy-mm-dd'
    minDate: 0

  $("#invoice_received_date").datepicker
    dateFormat: 'yy-mm-dd'
    maxDate: 0
