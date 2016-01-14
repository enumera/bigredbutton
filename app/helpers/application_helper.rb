module ApplicationHelper
	def dat_markdown(text)
		  options = {
	    :autolink => true,
	    :space_after_headers => true,
	    :no_intra_emphasis => true,
	    :hard_wrap => true,
	    :filter_html => true,
	    :fenced_code_blocks => true,
	    :prettify => true
	  }
	  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
	  syntax_highlighter(markdown.render(text)).html_safe

	end

	def syntax_highlighter(html)
	  doc = Nokogiri::HTML(html)
	  doc.search("//pre[@lang]").each do |pre|
	    pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
	  end
	  doc.to_s
	end
end

