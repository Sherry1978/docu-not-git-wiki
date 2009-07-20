xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
   xml.channel do
     xml.title( GitWiki::wiki_name )
     xml.link("localhost:3000")
     xml.description "All pages"
     xml.language "en-us"
     xml.ttl "40"

     for page in @pages
       xml.item do
         xml.title(page)
         xml.description(page.to_html)
         xml.link(page.url)
       end
     end
   end
 end
