module ApplicationHelper
  def markdown
    @markdown ||= Redcarpet::Markdown.new(MarkyRender.new(:prettify => true), :space_after_headers => true, :tables => true, :fenced_code_blocks => true, :footnotes => true)
  end
end
