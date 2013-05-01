jQuery ->
  $('.btn-destroy').click ->
    if !confirm("Are you sure you want to destroy this?")
      return false

  $("tbody tr:nth-child(odd)").addClass("odd")

  $('input.date').datepicker(
    {
      dateFormat: "yy-mm-dd",
      changeMonth: true,
      changeYear: true
    }
  )

  $('.squares-table a.btn-success, .boxes-table a.btn-success').tooltip()
  $('a.disabled').click ->
    false

  $('input.color-picker').miniColors()