$.extend $.fn,
  tmpl_replace: (data) ->
    $('<script type="text/x-jquery-tmpl">'+$(this).text().replace(/\/\/\$/g, "$").replace(/!/g, ".").replace(/_\(/g, "{").replace(/\)_/g, "}")+"<"+"/script>").tmpl(data)
  alert: (class_name, msgs) ->
    if typeof msgs == "string"
      msgs = [msgs]
    $($(this).find(".spinner")).hide()
    e_alert = $($(this).find(".alert"))
    e_alert.addClass("alert-"+class_name).html msgs.join("<br />")
    e_alert.show().delay(2000).slideUp "normal", ->
      $(this).removeClass("alert-"+class_name)
    true
  true

