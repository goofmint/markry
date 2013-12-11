class MarkyRender < Redcarpet::Render::HTML
  def block_code(code, language)
    "<pre class='prettyprint linenums'><code>#{CGI::escapeHTML code}</code></pre>"
  end
end
