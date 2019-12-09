read_html(url) : scrape HTML content from a given URL
html_nodes(): identifies HTML wrappers.
html_nodes(".class"): calls node based on CSS class
html_nodes("#id"): calls node based on <div> id
html_nodes(xpath="xpath"): calls node based on xpath (we'll cover this later)
html_attrs(): identifies attributes (useful for debugging)
html_table(): turns HTML tables into data frames
html_text(): strips the HTML tags and extracts only the text