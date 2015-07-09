# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  aval_articles = ""
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    reg = new RegExp('article_select','g')
    $(this).before($(this).data('fields').replace(regexp, time).replace(reg, 'article_select' + time))
    event.preventDefault()

    aval_articles = $(this).prev().find("select").html()
    provider = $('#purchase_order_provider_id :selected').text()
    escaped_provider = provider.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(aval_articles).filter("optgroup[label='#{escaped_provider}']").html()

    if options
      $(this).prev().find("select").html(options)
    else
      $(this).prev().find("select").empty()

  $('#purchase_order_provider_id').change ->
    items = $( "[id*='article_select']" )
    if items.length
      for item in items
        provider = $('#purchase_order_provider_id :selected').text()
        escaped_provider = provider.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
        options = $(aval_articles).filter("optgroup[label='#{escaped_provider}']").html()

        if options
          $(item).html(options)
        else
          $(item).empty()


  $('#purchase_orders').dataTable(
    {
      "language": {
        "sProcessing":    "Procesando...",
        "sLengthMenu":    "Mostrar _MENU_ registros",
        "sZeroRecords":   "No se encontraron resultados",
        "sEmptyTable":    "Ningún dato disponible en esta tabla",
        "sInfo":          "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
        "sInfoEmpty":     "Mostrando registros del 0 al 0 de un total de 0 registros",
        "sInfoFiltered":  "(filtrado de un total de _MAX_ registros)",
        "sInfoPostFix":   "",
        "sSearch":        "Buscar:",
        "sUrl":           "",
        "sInfoThousands":  ",",
        "sLoadingRecords": "Cargando...",
        "oPaginate": {
          "sFirst":    "Primero",
          "sLast":    "Último",
          "sNext":    "Siguiente",
          "sPrevious": "Anterior"
        },
        "oAria": {
          "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
          "sSortDescending": ": Activar para ordenar la columna de manera descendente"
        }
      },"jQueryUI": true
    });


