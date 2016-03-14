# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  aval_articles = ""
  data_articles = ""
  number_items = 0
  current_count = 0

  Enabler = ->
    if current_count==0
      $("#purchase_order_provider_id").removeAttr('readonly')
      $("#order_total_wrap").fadeOut(200)
      $("#submit_order").fadeOut(200)

  Bean_counter = ->
    sums = $("[id*='total_price']")
    total_sum = 0
    for ele in sums
      if $(ele).is(':visible')
        total_sum += Number($(ele).val().slice(1))
    $("#purchase_order_TotalAmount").val("$"+total_sum.toString())
    a = "A!"

  Field_setter = ->
    his = $(event.target)
    id_number = his.attr('id').slice(-1)
    id_current = his.val()
    if id_current == ""
      $("#purchase_order_item_purchase_orders_attributes_"+id_number+"_container_price").val("$0")
      $("#purchase_order_item_purchase_orders_attributes_"+id_number+"_units_per_container").val(0)
      $("#purchase_order_item_purchase_orders_attributes_"+id_number+"_total_price").val("$0")
    else
      target = null
      for item in data_articles.available
        if item.current_id.toString() == id_current
          target=item
          break
      $("#purchase_order_item_purchase_orders_attributes_"+id_number+"_container_price").val("$"+target.container_price.toString())
      $("#purchase_order_item_purchase_orders_attributes_"+id_number+"_units_per_container").val(target.units_per_container)
      amount = Number($("#purchase_order_item_purchase_orders_attributes_"+id_number+"_amount").val())
      $("#purchase_order_item_purchase_orders_attributes_"+id_number+"_total_price").val("$"+(amount * target.container_price).toString())
    Bean_counter()

  Field_updater = ->
    his = $(event.target)
    id_number = his.attr('id').split("_")
    id_number = id_number[id_number.length - 2]

    amount = Number($("#purchase_order_item_purchase_orders_attributes_"+id_number+"_amount").val())
    container_price = Number($("#purchase_order_item_purchase_orders_attributes_"+id_number+"_container_price").val().slice(1))
    $("#purchase_order_item_purchase_orders_attributes_"+id_number+"_total_price").val("$"+(amount * container_price).toString())
    Bean_counter()

  Data_retriever = ->
    items = $("[id*='article_select']" )
    provider_id = $('#purchase_order_provider_id :selected').val()
    if provider_id == ""
      $("#add_purchase_item").hide()
    else
      if current_count != 0
        for item in items
          provider = $('#purchase_order_provider_id :selected').text()
          escaped_provider = provider.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')

          options = $(aval_articles).filter("optgroup[label='#{escaped_provider}']").html()
          options = "<option value='' selected='selected'></option>" + options

          if options
            $(item).html(options)
          else
            $(item).empty()
      else
        $("#add_purchase_item").hide()
        $.getJSON("/providers/"+provider_id+".json",{},(resp_data,status) ->
          data_articles = resp_data
          $("#add_purchase_item").show())

  Price_updater = (loc) ->
    if loc
      updated_id = $(loc).find("input[type=hidden][id$='current_version_id']").val()
      updated_article = null
      $.getJSON("/provider_articles/"+updated_id+".json",{},(resp_data,status) ->
        updated_article = resp_data
        $(loc).find("input[id$='container_price']").val(updated_article.container_price)
        $(loc).find("input[id$='units_per_container']").val(updated_article.units_per_container)
    )


  Price_updater($(".form-inputs.row")[0])


  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val(true)
    $(this).closest('.row').hide()
    Bean_counter()
    current_count = current_count-1
    Enabler()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    $("#purchase_order_provider_id").attr("readonly","true")
    regexp = new RegExp($(this).data('id'), 'g')
    reg = new RegExp('article_select','g')
    $(this).before($(this).data('fields').replace(regexp, number_items).replace(reg, 'article_select' + number_items))
    $(this).prev().fadeIn(200)

    number_items += 1
    current_count += 1

    $(this).prev().find("select").change ->
      Field_setter(this)
    $(this).prev().find("input").first().change ->
      Field_updater(this)
    event.preventDefault()

    aval_articles = $(this).prev().find("select").html()
    provider = $('#purchase_order_provider_id :selected').text()
    escaped_provider = provider.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(aval_articles).filter("optgroup[label='#{escaped_provider}']").html()
    options = "<option value='' selected='selected'></option>" + options

    if options
      $(this).prev().find("select").html(options)
    else
      $(this).prev().find("select").empty()

    $("#order_total_wrap").fadeIn(200)
    $("#submit_order").fadeIn(200)

  $('#purchase_order_provider_id').change ->
    Data_retriever(this)

  action = window.location.pathname.split("/")
  action = action[action.length-1]

  if action == "edit"
    $("#submit_order").fadeIn(200)
    $("#order_total_wrap").fadeIn(200)
    Data_retriever()
    number_items = $("#purchase_order_provider_id").data("existing-items")
    for ele in $("[id$='_price']")
      $(ele).val("$"+$(ele).val())

    for ele in $("[id$='_amount']")
      $(ele).change ->
        Field_updater(this)



  $("#purchase_order_sendDate").datepicker
    dateFormat: 'yy-mm-dd',
    minDate: 0,
    setDate: new Date()

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

