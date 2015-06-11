Calculador = ->
  his = event.target
  id = his.id
  value1 = (id[id.length - 1] + 1)%3
  value2 = (id[id.length - 1] + 2)%3
  s1 = id[0] + "inputmultiple" + value1
  s2 = id[0] + "inputmultiple" + value2
  $("#"+s1).attr("value", value1)
  $("#"+s2).attr("value", value2)



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
