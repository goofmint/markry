# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ajax_logs = {}
link_view = (hash) ->
  html = '<div class="media"><a class="pull-left" href="'+link.href+'"><img width="180px" class="media-object" src="'+data.images[0]+'" alt=""></a><div class="media-body"><h4 class="media-heading">'+data.title+'</h4><div class="caption">'+data.content+'</div></div></div>';
  $(".html-preview-"+hash).html html
  $(".html-preview-"+hash).find('.caption').trunk8
    lines: 3

marked.InlineLexer.prototype.outputLink = (cap, link) ->
  if cap[0].charAt(0) != "!"
    hash = CybozuLabs.MD5.calc(link.href)
    if ajax_logs[hash]
      data = ajax_logs[hash]
      html = '<div class="media"><a class="pull-left" href="'+link.href+'"><img width="180px" class="media-object" src="'+data.images[0]+'" alt=""></a><div class="media-body"><h4 class="media-heading">'+data.title+'</h4>'+data.content+'</div></div>'
      str  = "<p class='html-preview-"+ hash+"'>"+html+"</p>"
      str += "<p>" + cap[1] + "</p>"
      return str
    else
      matches = link.href.match(/http.?:\/\/www\.youtube\.com\/watch\?v=(.*)($|&)/)
      if matches
        return '<p><iframe width="100%" height="480" src="//www.youtube.com/embed/'+matches[1]+'" frameborder="0" allowfullscreen></iframe></p>'
      matches = link.href.match(/http.?:\/\/gist\.github\.com\/(.*)($|&)/)
      if matches
        return '<p><iframe width="100%" height="480" src="/embed/?url=https://gist.github.com/'+matches[1]+".js"+'" frameborder="0" allowfullscreen></iframe></p>'
      $.ajax
        url: "http://enigmatic-beach-7226.herokuapp.com/?url="+encodeURIComponent link.href
        dataType: 'jsonp'
        success: (data) ->
          html = '<div class="media"><a class="pull-left" href="'+link.href+'"><img width="180px" class="media-object" src="'+data.images[0]+'" alt=""></a><div class="media-body"><h4 class="media-heading">'+data.title+'</h4><div class="caption">'+data.content+'</div></div></div>';
          $(".html-preview-"+hash).html html
          $(".html-preview-"+hash + " .caption").trunk8
            lines: 3
          data.content = $(".html-preview-"+hash + " .caption").text()
          ajax_logs[hash] = data
    str  = "<p class='html-preview-"+ hash+"'></p>"
    str += "<p>" + cap[1] + "</p>"
  else
    str = "<img src=\"" + link.href + "\" alt=\"" + cap[1] + "\" />"
    if link.title
      str += "<p>via <a href='"+ link.title + "'>"+url('hostname', link.title)+"</a></p>"
    if cap[1]
      str += "<p>"+ cap[1] + "</p>"
    str
$ ->
  markdown = $("#summary_body").markdown
    additionalButtons: [
      [
        name: "groupCustom"
        data: [
            name: "cmdQuote"
            toggle: true
            title: "引用"
            icon: "glyphicon glyphicon-bullhorn"
            callback: (e) ->
              selected = e.getSelection()
              content = e.getContent()
              chunk = if selected.length == 0 then "引用" else selected.text
              if selected.text == ""
                e.replaceSelection("> "+chunk+"\n\nvia http://example.com/\n\nメモ\n")
                cursor = selected.start+2
                e.setSelection(cursor,cursor+chunk.length)
          ,
            name: "cmdCode"
            toggle: true
            title: "コード"
            icon: "glyphicon glyphicon-cog"
            callback: (e) ->
              selected = e.getSelection()
              content = e.getContent()
              chunk = if selected.length == 0 then "puts 'Hello World'" else selected.text
              if selected.text == ""
                e.replaceSelection("```\n"+chunk+"\n```\n")
                cursor = selected.start+4
                e.setSelection(cursor,cursor+chunk.length)
        ]
      ]
    ]
    onShow: (e) ->
      e.disableButtons("cmdItalic")
      e.disableButtons("cmdBold")
      e.disableButtons("cmdList")
      e.disableButtons("cmdPreview")
      $("button[disabled='disabled']").hide()
  $(window).resize (e) ->
    $("#summary_body,.preview").css
      height: $(window).height() - 190
  $("#summary_body,.preview").css
    height: $(window).height() - 190
  preview_show = ->
    hash = CybozuLabs.MD5.calc($("#summary_body").val().replace(/\r|\n/, ""))
    return true if hash == last_hash
    marked.setOptions
      sanitize: true
    $(".preview").html marked($("#summary_body").val())
    last_hash = hash
  $("#summary_body").keypress (e) ->
    preview_show()
  $("#summary_body").keyup (e) ->
    preview_show()
  preview_show()
  true

