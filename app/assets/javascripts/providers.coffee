Calculador = ->
  his = event.target
  id = his.id
  s1 = $("#"+id[0] + "inputmultiple" + ((id[id.length - 1] + 1)%3))
  s2 = $("#"+id[0] + "inputmultiple" + ((id[id.length - 1] + 2)%3))

  if id[id.length - 1] == "0"
    if (s1.val() != "0") and (s2.val() != "0" and  !!s1.val() and  !!s2.val())
        s2.val(his.value * s1.val())
    else if (s1.val() != "0" and  !!s1.val())
      s2.val(his.value * s1.val())
    else if (s2.val() != "0" and  !!s2.val())
      s1.val(s2.val/his.value)

  else if id[id.length - 1] == "1"
    if (s1.val() != "0") and (s2.val() != "0" and  !!s1.val() and  !!s2.val())
      s1.val(his.value * s2.val())
    else if (s2.val() != "0" and  !!s2.val())
      s1.val(his.value * s2.val())
    else if (s1.val() != "0" and  !!s1.val())
      s2.val((parseInt(s1.val())/parseInt(his.value)).toFixed(2))

  else if id[id.length - 1] == "2"
    if (s1.val() != "0") and (s2.val() != "0" and  !!s1.val() and  !!s2.val())
      s1.val((parseInt(his.value) / parseInt(s2.val())).toFixed(2))
    else if (s1.val() != "0" and  !!s1.val())
      s2.val((parseInt(his.value) / parseInt(s1.val())).toFixed(2))
    else if (s1.val() != "0" and  !!s2.val())
      s1.val((parseInt(s2.val())/parseInt(his.value)).toFixed(2))









jQuery ->
    $('#providers').dataTable(
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
    $("[id*='inputmultiple']").blur ->
      Calculador(this)
